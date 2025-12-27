package com.scddm.service;

import com.scddm.mapper.UserMapper;
import com.scddm.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    public User login(String username, String password) {
        User user = mapper.selectByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    public void register(User user) {
        mapper.insert(user);
    }

    @Autowired
    private UserMapper mapper;

    public List<User> list(){
        return mapper.selectAll();
    }

    public void add(User user){
        // 密码不再加密，直接存储
        mapper.insert(user);
    }

    public void update(User user){
        mapper.update(user);
    }

    public void delete(Integer id){
        mapper.delete(id);
    }

    public User findByUsername(String username){
        return mapper.selectByUsername(username);
    }
}
