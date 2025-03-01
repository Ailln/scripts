import redis
import time

# 连接 Redis
redis_client = redis.StrictRedis(host='localhost', port=6379, password='123456', decode_responses=True)

STREAM_NAME = "my_stream"
GROUP_NAME = "my_group"
CONSUMER_NAME = "consumer_1"
CONSUMER_NUM = 5

def create_consumer_group():
    """创建消费者组（仅需执行一次）"""
    try:
        redis_client.xgroup_create(STREAM_NAME, GROUP_NAME, id='0', mkstream=True)
        print(f"Consumer Group '{GROUP_NAME}' created.")
    except redis.exceptions.ResponseError:
        print(f"Consumer Group '{GROUP_NAME}' already exists.")

def consumer():
    """消费者：从 Stream 读取并处理消息"""
    while True:
        try:
            messages = redis_client.xreadgroup(GROUP_NAME, CONSUMER_NAME, {STREAM_NAME: '>'},
                                               count=CONSUMER_NUM, block=1000)
            if messages:
                for stream, message_list in messages:
                    for message_id, message_data in message_list:
                        print(f"[Consumer] Received: {message_data} (ID: {message_id})")
                        redis_client.xack(STREAM_NAME, GROUP_NAME, message_id)
                        print(f"[Consumer] Acknowledged: {message_id}")
                        # 删除已确认的消息
                        redis_client.xdel(STREAM_NAME, message_id)
                        print(f"[Consumer] Deleted: {message_id}")
        except Exception as e:
            print(f"[Consumer] Error: {e}")
        time.sleep(1)

if __name__ == "__main__":
    create_consumer_group()  # 只需执行一次
    consumer()
