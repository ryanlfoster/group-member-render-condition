<%--
  by Ben Stockwell
     http://scrupulo.com
     https://github.com/scrupulo/group-member-render-condition
--%><%
%><%@include file="/libs/granite/ui/global.jsp" %><%
%><%@page session="false"
          import="org.apache.sling.api.resource.ResourceResolver,
                  com.adobe.granite.ui.components.Config,
                  org.apache.jackrabbit.api.security.user.UserManager,
                  com.aem.community.gmrc.core.MemberOfRenderCondition,
                  com.adobe.granite.ui.components.rendercondition.RenderCondition" %><%

Config cfg = cmp.getConfig();

String authorizable = cmp.getExpressionHelper().getString(cfg.get("authorizableID", request.getRemoteUser()));
String[] groups = cfg.get("groupID", new String[0]);
boolean declaredOnly = cfg.get("declaredOnly", false);

if (authorizable.length() == 0 || groups.length == 0) {
    return;
}

UserManager userManager = resourceResolver.adaptTo(UserManager.class);

request.setAttribute(RenderCondition.class.getName(), new MemberOfRenderCondition(userManager,authorizable, groups, declaredOnly));
%>