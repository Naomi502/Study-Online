package com.jd.util;

import com.jd.entity.Comment;
import com.jd.entity.Tree;

import java.util.ArrayList;
import java.util.List;

/**
 * @author yjw
 * @date 2020/7/28
 */
public class NodeUtil {

    private static final Integer LEVEL_1 = 1;

    /**
     * 获取目录根节点
     *
     * @return
     */
    public static List<Tree> getRootNode(List<Tree> nodeList) {
        List<Tree> list = new ArrayList<>();
        for (Tree t : nodeList) {
            if (LEVEL_1.equals(t.getLevel())) {
                list.add(t);
            }
        }
        return list;
    }

    /**
     * 根据pid查询子节点
     *
     * @param nodeList
     * @return
     */
    public static List<Tree> getChilNode(List<Tree> nodeList, Tree t) {
        //  为每一个树节点都创建一个Children
        t.setChildren(new ArrayList<>());
        //  这里获取是为了放入数据
        List<Tree> list = t.getChildren();
        for (Tree tree : nodeList) {
            //  判断当前的父id是否等于父节点id
            if (t.getId()==tree.getPid()) {
                //  是的话传入父类的子集合中
                list.add(tree);
                //  表示节点为该父id
                getChilNode(nodeList, tree);
            }
        }
        //  这个返回其实只有返回总树结构有用
        return list;
    }

}