import redis
import time

redis_client = redis.StrictRedis(host='localhost', port=6379, password='123456', decode_responses=True)

STREAM_NAME = "my_stream"

def producer():
    """生产者：向 Stream 添加消息"""
    for i in range(1, 1000):
        message = {"message_id": str(i), "content": f"Hello Redis Stream {i}"}
        message_id = redis_client.xadd(STREAM_NAME, message)
        print(f"[Producer] Sent: {message}, ID: {message_id}")
        time.sleep(0.1)

if __name__ == "__main__":
    producer()