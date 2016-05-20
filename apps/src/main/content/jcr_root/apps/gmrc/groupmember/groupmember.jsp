<%--
  ADOBE CONFIDENTIAL

  Copyright 2014 Adobe Systems Incorporated
  All Rights Reserved.

  NOTICE:  All information contained herein is, and remains
  the property of Adobe Systems Incorporated and its suppliers,
  if any.  The intellectual and technical concepts contained
  herein are proprietary to Adobe Systems Incorporated and its
  suppliers and may be covered by U.S. and Foreign Patents,
  patents in process, and are protected by trade secret or copyright law.
  Dissemination of this information or reproduction of this material
  is strictly forbidden unless prior written permission is obtained
  from Adobe Systems Incorporated.
--%><%
%><%@include file="/libs/granite/ui/global.jsp" %><%
%><%@page session="false"
          import="org.apache.sling.api.resource.ResourceResolver,
                  com.adobe.granite.ui.components.Config,
                  org.apache.jackrabbit.api.security.user.UserManager,
                  com.aem.community.gmrc.core.MemberOfRenderCondition,
                  com.adobe.granite.ui.components.rendercondition.RenderCondition" %><%--###
Privilege
=========

   .. granite:servercomponent: /apps/gmrc/groupmember
   :rendercondition:
   
   returns true is user is member of group
   
   It has the following content structure:

   .. gnd:gnd::

      [granite:RenderConditionsPrivilege]
      
      /**
       * The Authorizable ID -- optional -- defaults to remote user from request
       */
      - authorizableID (StringEL)
      
      /**
       * The Group names.
       */
      - groupID (String) multiple
      
      /**
       * Declared memberships (not transitive) only
       */
      - declaredOnly (Boolean)

###--%><%

Config cfg = cmp.getConfig();

String authorizable = cmp.getExpressionHelper().getString(cfg.get("authorizableID", request.getRemoteUser()));
String[] groups = cfg.get("groupID", new String[0]);
boolean declaredOnly = cfg.get("declaredOnly", false);]);
boolean all = cfg.get("all", false);

if (authorizable.length() == 0 || groups.length == 0) {
    return;
}

UserManager userManager = resourceResolver.adaptTo(UserManager.class);

request.setAttribute(RenderCondition.class.getName(), new MemberOfRenderCondition(userManager,authorizable, groups, declaredOnly));
%>