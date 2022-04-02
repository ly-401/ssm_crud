package com.sxt.domain;

import java.util.HashMap;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 *
 * @Author: Future
 * @Date: 2021/12/02/11:26
 *
 * 通用的返回的类，为Json提供状态
 */
public class Msg {

    //状态码   200-成功  404-失败
    private int status;

    //提示信息
    private String msg;

    //用户要返回给浏览器的数据
    private Map<String,Object> extend = new HashMap<String, Object>();

    //快速获取Json处理状态-----成功
    public static Msg success(){
        Msg msg = new Msg();
        msg.setStatus(200);
        msg.setMsg("处理成功！");

        return msg;
    }

    //快速获取Json处理状态-----失败
    public static Msg fail(){
        Msg msg = new Msg();
        msg.setStatus(404);
        msg.setMsg("处理失败！");

        return msg;
    }

    public Msg add(String key,Object value){
        this.getExtend().put(key,value);

        return this;
    }


    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }

}
