import plyvel
import struct

def encode_block_number(number):
    return struct.pack('>Q', number)  # Big endian uint64

def get_block(db_path, block_number):
    db = plyvel.DB(db_path, compression=None)
    block_body_prefix = b'b'  # blockBodyPrefix as defined in schema.go
    encoded_number = encode_block_number(block_number)

    for key, value in db:
        if key.startswith(block_body_prefix + encoded_number):
            db.close()
            return value

    db.close()
    return None

if __name__ == "__main__":
    db_path = './chaindata'
    block_number = 20001
    block_data = get_block(db_path, block_number)

    if block_data:
        print(f"Block data for block number {block_number}: {block_data}")
    else:
        print(f"Block number {block_number} not found.")
