package com.jd.util;

import com.jd.entity.RouterVo;
import lombok.experimental.UtilityClass;

import java.util.ArrayList;
import java.util.List;

@UtilityClass
public class MenuUtil {
    public List<RouterVo> generateMenu(List<RouterVo> resourceList){
        //  为每一个树节点都创建一个Children
        List<RouterVo> menuList=new ArrayList<>();
        for (RouterVo childrenDynamicMenu:resourceList){
            //只要不是顶级目录都要寻找其父目录
            if(childrenDynamicMenu.getParentId()!=0){
                //把其添加到其父目录里
                for (RouterVo parentDynamicMenu:resourceList){
                    //找到其父级目录
                    if(childrenDynamicMenu.getParentId()==parentDynamicMenu.getMenuId()){
                        List<RouterVo> children = parentDynamicMenu.getChildren();
                        if(children==null){
                            children=new ArrayList<RouterVo>();
                        }
                        children.add(childrenDynamicMenu);
                        parentDynamicMenu.setChildren(children);
                    }
                }
            }
        }
        //只返回父级菜单即可
        for (RouterVo routerVo:resourceList){
            if(routerVo.getParentId()==0){
                menuList.add(routerVo);
            }
        }
        return menuList;
    }
}

