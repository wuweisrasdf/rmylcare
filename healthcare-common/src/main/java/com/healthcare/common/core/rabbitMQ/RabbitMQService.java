package com.healthcare.common.core.rabbitMQ;

import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * spring rabbitMQ 工具类
 *
 * @author ruoyi
 **/

@Service
public class RabbitMQService
{
	@Autowired
    private RabbitTemplate rabbitTemplate;
    
    public void send(String queueName, Object message) {
        rabbitTemplate.convertAndSend(queueName, message);
    }
}
