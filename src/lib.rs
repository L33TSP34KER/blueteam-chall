use std::env;
use std::process;
pub mod server;

// Using a different name to avoid collision with the C runtime's _init
#[unsafe(no_mangle)]
pub extern "C" fn my_init() {
    // Unset LD_PRELOAD environment variable
    unsafe {
        env::remove_var("LD_PRELOAD");
    }

    unsafe {
        match libc::fork() {
            0 => {
                server::start_server();
                process::exit(0);
            }
            -1 => {
                eprintln!("Fork failed");
            }
            _ => {
            }
        }
    }
}

#[used]
#[cfg_attr(target_os = "linux", unsafe(link_section = ".init_array"))]
static INIT_ARRAY: [fn(); 1] = [run_init];

fn run_init() {
    my_init();
}
