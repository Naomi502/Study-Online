import Layout from "@/layout";

export function mapRouteToVueRouter(route) {
  return {
    path: route.path,
    name: route.name || "",
    hidden:route.hidden,
    redirect:route.redirect,
    component:
    route.component === "Layout"
        ? Layout
        : (resolve) => require([`@/views/${route.component}`], resolve),
    children: route.children
      ? route.children.map((child) => mapRouteToVueRouter(child))
      : [],
    meta: {
      title: route.meta.title || "",
      icon: route.meta.icon || [],
    },
  };
}
