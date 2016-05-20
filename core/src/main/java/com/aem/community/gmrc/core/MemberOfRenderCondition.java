package com.aem.community.gmrc.core;

import java.util.Iterator;

import javax.jcr.RepositoryException;
import javax.servlet.ServletException;

import org.apache.jackrabbit.api.security.user.Authorizable;
import org.apache.jackrabbit.api.security.user.Group;
import org.apache.jackrabbit.api.security.user.UserManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.adobe.granite.ui.components.rendercondition.RenderCondition;

public class MemberOfRenderCondition implements RenderCondition {
	
	String authorizableID;
	String[] groups;
	boolean declaredOnly;
	boolean all;
    
	UserManager userManager;

    private static final Logger log = LoggerFactory.getLogger(MemberOfRenderCondition.class);

	public MemberOfRenderCondition(UserManager userManager, String authorizableID, String[] groups, boolean declaredOnly) {
		this.authorizableID = authorizableID;
		this.groups = groups;
		this.declaredOnly = declaredOnly;
		this.userManager = userManager;
		
	}
	
	public boolean check() throws ServletException {
		
		try {
			Authorizable auth = userManager.getAuthorizable(authorizableID);
			Iterator<Group> ig = auth.memberOf();
			if(declaredOnly)
				ig = auth.declaredMemberOf();

			while(ig.hasNext()) {
				Group g = ig.next();
				for(String s : groups) {
					log.error(s);
					log.error(g.getID());
					if(g.getID().equals(s.trim())) {
						return true;
					}
				}
			}
		} catch (RepositoryException e) {
			log.error("error",e);
			return false;
		}

		return false;
	}
	
}