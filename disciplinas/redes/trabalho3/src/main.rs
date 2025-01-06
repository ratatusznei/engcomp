use std::{
    fs::File,
    io::{prelude::*, BufRead, BufReader, Write},
    net::{TcpListener, TcpStream},
    path::Path,
    thread,
};

fn main() -> std::io::Result<()> {
    let port = std::env::args().nth(1).unwrap_or(String::from("9090"));
    let tcp_listener = TcpListener::bind(format!("0.0.0.0:{port}"))?;
    println!("Listening on http://0.0.0.0:{port}");

    while let Ok((stream, _addr)) = tcp_listener.accept() {
        thread::spawn(|| {
            handle_connection(stream);
        });
    }

    Ok(())
}

fn handle_connection(mut stream: TcpStream) {
    let buf_read = BufReader::new(&mut stream);

    let request_line = buf_read.lines().map(|line| line.unwrap()).next().unwrap();
    let mut request_line = request_line.split(' ');

    let method = request_line.next().unwrap();
    let file = format!("assets/{}", request_line.next().unwrap());
    let _version = request_line.next().unwrap();

    let file_path = Path::new(&file);

    let (status_line, response) = if method != "GET" {
        (
            "HTTP/1.0 405 Method Not Allowed\r\nAllow: GET\r\n\r\n".as_bytes(),
            vec![].to_owned(),
        )
    } else if file_path.is_file() {
        let mut file = File::open(file_path).unwrap();
        let mut contents = vec![];
        file.read_to_end(&mut contents).unwrap();

        ("HTTP/1.0 200 OK\r\n\r\n".as_bytes(), contents.to_owned())
    } else {
        let mut file = File::open("assets/404.html").expect("File 404.html not found.");
        let mut contents = vec![];
        file.read_to_end(&mut contents).unwrap();
        (
            "HTTP/1.0 404 Not Found\r\n\r\n".as_bytes(),
            contents.to_owned(),
        )
    };

    stream.write_all(status_line).unwrap();
    stream.write_all(&response).unwrap();
}
