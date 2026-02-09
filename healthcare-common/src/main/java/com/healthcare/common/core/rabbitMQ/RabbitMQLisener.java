package com.healthcare.common.core.rabbitMQ;

import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.BoundSetOperations;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Component;

/**
 * spring rabbitMQ 工具类
 *
 * @author ruoyi


@Component
public class RabbitMQLisener
{
	@RabbitListener(queues = "HEALTHCARE_MQ_Test")
    public  void setCacheObject(String message)
    {
        System.out.print(message);
    }
}
 **/