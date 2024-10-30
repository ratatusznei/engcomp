//! # Protocolo de transferência
//!
//! ## Fluxos de operação
//!
//! ### Fluxo: Transferência de arquivo
//! ```text
//!                                                        Servidor
//!                                                            T
//!                                                            | (Starts)
//!                                                            ⋮
//!               Cliente                                      |
//!                  T                                         |
//!                  | (Starts)                                |
//!                  |                                         |
//!               GET_INFO --------------------------------->  +
//!                  |                                         |
//!                  |                                         |
//!                  +  <------------------------------------ INFO
//!                  | (Allocates memory for file)             |
//!                  |                                         |
//!              GET_BLOCKS -------------------------------->  +
//!                  |                                         |
//!                  |                                         |
//!                  +  <------------------------------------ BLOCK 0
//!                  |                                         |
//!                  |                                         ⋮
//!                  |                                         |
//!                  +  <------------------------------------ BLOCK n
//!                  |                                         |
//!                  ⋮                                         ⋮
//!                  | (Requests missing blocks)               |
//!              GET_BLOCKS -------------------------------->  +
//!                  |                                         |
//!                  |                                         |
//!                  +  <------------------------------------ BLOCK x
//!                  |                                         |
//!                  |                                         ⋮
//!                  |                                         |
//!                  +  <------------------------------------ BLOCK y
//!                  |                                         |
//!                  |                                         |
//!                  ⋮ (Receives all blocks)                   ⋮
//!                  |                                         |
//!                  |                                         |
//!                  x (Finishes after saving file to disk)    ⋮
//! ```
//!
//!
//! ### Fluxo: Arquivo Inexistente
//! ```text
//!                                                        Servidor
//!                                                            T
//!                                                            | (Starts)
//!                                                            ⋮
//!               Cliente                                      |
//!                  T                                         |
//!                  | (Starts)                                |
//!                  |                                         |
//!               GET_INFO --------------------------------->  +
//!                  |                                         |
//!                  |                                         |
//!                  +  <--------------------------------  NOT_FOUND
//!                  |                                         |
//!                  |                                         |
//!                  x (Finishes)                              ⋮
//! ```
//!
//!
//! ## Formato das mensagens
//!
//! Mensagens são codificadas em binário.
//!
//! O primeiro campo de cada mensagem é um unsigned de 32 bits identificando o tipo de mensagem.
//!
//!
//! ### GET_INFO
//! - Código: `0`
//! - Nome do arquivo em UTF-8
//!
//! ### INFO
//! - Código: `1`
//! - Quantidade de blocos (uint 32 bits)
//! - Tamanho do bloco em octetos (uint 32 bits)
//! - Tamanho do arquivo em octetos (uint 32 bits)
//! - Checksum do arquivo (uint 32 bits)
//! - Id do arquivo (uint 32 bits)
//! - Nome do arquivo em UTF-8
//!
//! O arquivo é dividido em blocos. O campo "tamanho do bloco" é o tamanho deles exceto o último
//! que pode server menor. Esse tamanho é APENAS o tamanho do campo "Dados binários" da mensagem
//! BLOCK.
//!
//! ### NOT_FOUND
//! - Código: `404`
//! - filename
//!
//! ### GET_BLOCKS
//! - Código: `2`
//! - Inicio (uint 32 bits)
//! - Fim (uint 32 bits)
//! - Id do arquivo (uint 32 bits)
//! Requisita blocos no intervalo [Inicio, Fim).
//!
//! ### BLOCK
//! - Código: `3`
//! - Id do arquivo (uint 32 bits)
//! - Número do bloco (uint 32 bits)
//! - Dados binários

use std::fmt;
use std::net::{SocketAddr, ToSocketAddrs, UdpSocket};

pub enum Message {
    GetInfo {
        file_name: String,
    },
    Info {
        block_count: u32,
        block_size: u32,
        file_size: u32,
        checksum: u32,
        file_id: u32,
        file_name: String,
    },
    NotFound {
        file_name: String,
    },
    GetBlocks {
        start_block: u32,
        end_block: u32,
        file_id: u32,
    },
    Block {
        file_id: u32,
        block_number: u32,
        data: Vec<u8>,
    },
}

impl fmt::Display for Message {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
        match self {
            Message::GetInfo { file_name } => 
                write!(f, "GetInfo {{ file_name: {} }}", file_name),
            Message::Info { block_count, block_size, file_size, checksum, file_id, file_name } =>
                write!(f,
                    "Info {{ block_count: {}, block_size: {}, file_size: {}, checksum: {}, file_id: {}, file_name: {} }}",
                    block_count, block_size, file_size, checksum, file_id, file_name
                ),
            Message::NotFound { file_name } =>
                write!(f, "NotFound {{ file_name: {} }}", file_name),
            Message::GetBlocks { start_block, end_block, file_id } =>
                write!(f, "GetBlocks {{ start: {}, end: {}, file_id: {} }}", start_block, end_block, file_id),
            Message::Block { file_id, block_number, .. } =>
                write!(f, "Block {{ file_id: {}, block_number: {} }}", file_id, block_number),
        }
    }
}

pub trait MessageSocket {
    fn send_message<A>(&self, dest: A, message: Message) -> std::io::Result<usize>
    where
        A: ToSocketAddrs;
    fn recv_message(&self) -> Option<(Message, SocketAddr)>;
}

impl Message {
    pub const GET_INFO: u32 = 0;
    pub const INFO: u32 = 1;
    pub const NOT_FOUND: u32 = 404;
    pub const GET_BLOCKS: u32 = 2;
    pub const BLOCK: u32 = 3;

    pub fn get_info(file_name: &str) -> Self {
        let file_name = String::from(file_name);

        Message::GetInfo { file_name }
    }

    pub fn info(
        block_count: u32,
        block_size: u32,
        file_size: u32,
        checksum: u32,
        file_id: u32,
        file_name: &str,
    ) -> Self {
        let file_name = String::from(file_name);

        Message::Info {
            block_count,
            block_size,
            file_size,
            checksum,
            file_id,
            file_name,
        }
    }

    pub fn not_found(file_name: &str) -> Self {
        let file_name = String::from(file_name);

        Message::NotFound { file_name }
    }

    pub fn get_blocks(file_id: u32, start_block: u32, end_block: u32) -> Self {
        Message::GetBlocks {
            file_id,
            start_block,
            end_block,
        }
    }

    pub fn block(file_id: u32, block_number: u32, data: &[u8]) -> Self {
        let data = data.to_vec();

        Message::Block {
            file_id,
            block_number,
            data,
        }
    }

    pub fn into_bytes(self) -> Vec<u8> {
        let mut vec = vec![];

        match self {
            Message::GetInfo { file_name } => {
                vec.extend(&Message::GET_INFO.to_be_bytes());
                vec.extend(file_name.as_bytes());
            }

            Message::Info {
                block_count,
                block_size,
                file_size,
                checksum,
                file_id,
                file_name,
            } => {
                vec.extend(&Message::INFO.to_be_bytes());
                vec.extend(&block_count.to_be_bytes());
                vec.extend(&block_size.to_be_bytes());
                vec.extend(&file_size.to_be_bytes());
                vec.extend(&checksum.to_be_bytes());
                vec.extend(&file_id.to_be_bytes());
                vec.extend(file_name.as_bytes());
            }

            Message::NotFound { file_name } => {
                vec.extend(&Message::NOT_FOUND.to_be_bytes());
                vec.extend(file_name.as_bytes());
            }

            Message::GetBlocks {
                start_block,
                end_block,
                file_id,
            } => {
                vec.extend(&Message::GET_BLOCKS.to_be_bytes());
                vec.extend(&start_block.to_be_bytes());
                vec.extend(&end_block.to_be_bytes());
                vec.extend(&file_id.to_be_bytes());
            }

            Message::Block {
                file_id,
                block_number,
                data,
            } => {
                vec.extend(&Message::BLOCK.to_be_bytes());
                vec.extend(&file_id.to_be_bytes());
                vec.extend(&block_number.to_be_bytes());
                vec.extend(data);
            }
        }

        vec
    }

    pub fn from_bytes(data: &[u8], len: usize) -> Option<Self> {
        let opcode: [u8; 4] = data[0..4].try_into().unwrap();
        let opcode = u32::from_be_bytes(opcode);

        match opcode {
            Message::GET_INFO => {
                let file_name = data[4..len].to_vec();
                let file_name = String::from_utf8(file_name).ok()?;

                Some(Message::get_info(&file_name))
            }

            Message::INFO => {
                let block_count: [u8; 4] = data[4..8].try_into().unwrap();
                let block_count = u32::from_be_bytes(block_count);

                let block_size: [u8; 4] = data[8..12].try_into().unwrap();
                let block_size = u32::from_be_bytes(block_size);

                let file_size: [u8; 4] = data[12..16].try_into().unwrap();
                let file_size = u32::from_be_bytes(file_size);

                let checksum: [u8; 4] = data[16..20].try_into().unwrap();
                let checksum = u32::from_be_bytes(checksum);

                let file_id: [u8; 4] = data[20..24].try_into().unwrap();
                let file_id = u32::from_be_bytes(file_id);

                let file_name = data[24..len].to_vec();
                let file_name = String::from_utf8(file_name).ok()?;

                Some(Message::info(
                    block_count,
                    block_size,
                    file_size,
                    checksum,
                    file_id,
                    &file_name,
                ))
            }

            Message::NOT_FOUND => {
                let file_name = data[4..len].to_vec();
                let file_name = String::from_utf8(file_name).ok()?;

                Some(Message::not_found(&file_name))
            }

            Message::GET_BLOCKS => {
                let start_block: [u8; 4] = data[4..8].try_into().unwrap();
                let start_block = u32::from_be_bytes(start_block);

                let end_block: [u8; 4] = data[8..12].try_into().unwrap();
                let end_block = u32::from_be_bytes(end_block);

                let file_id: [u8; 4] = data[12..len].try_into().unwrap();
                let file_id = u32::from_be_bytes(file_id);

                Some(Message::get_blocks(file_id, start_block, end_block))
            }

            Message::BLOCK => {
                let file_id: [u8; 4] = data[4..8].try_into().unwrap();
                let file_id = u32::from_be_bytes(file_id);

                let block_number: [u8; 4] = data[8..12].try_into().unwrap();
                let block_number = u32::from_be_bytes(block_number);

                let data = &data[12..len];

                Some(Message::block(file_id, block_number, data))
            }

            _ => None,
        }
    }
}

impl MessageSocket for UdpSocket {
    fn send_message<A>(&self, dest: A, message: Message) -> std::io::Result<usize>
    where
        A: ToSocketAddrs,
    {
        println!("--> {}", message);
        self.send_to(&message.into_bytes(), dest)
    }

    fn recv_message(&self) -> Option<(Message, SocketAddr)> {
        let mut buf = [0; 1024];
        let (len, src) = self.recv_from(&mut buf).ok()?;
        let message = Message::from_bytes(&buf, len).map(|message| (message, src));
        if let Some((msg, _)) = &message {
            println!("<-- {}", msg);
        } else {
            println!("Received malformed message");
        }
        message
    }
}
