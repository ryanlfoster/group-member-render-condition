Group Member Render Condition
=============================

A Maven package for AEM 6.2 that adds a render condition to check if a given user is in at least one of a list of groups before rendering a component.

[Github Repo]

To Install
----------

1.  Download the package and unzip
2.  The project has 2 profiles that can be run like:
    -   `mvn -PautoInstallBundle install`
        – Installs only the base code, without examples
    -   `mvn -PautoInstallExample install`
        – Installs the base code and the examples

### Installed files:

-   /jcr:root/apps/gmrc/groupmember – jsp file to be referenced in Granite markup
-   com.aem.community.gmrc.core.MemberOfRenderCondition – Java class containing to test for the group membership, called from groupmember.jsp
-   /jcr:root/apps/gmrc/example (example profile only)
-   /jcr:root/content/gmrc (example profile only)

Usage
-----

Use on any granite element that supports &lt;renderconditions /&gt;:

            <rendercondition jcr:primaryType="nt:unstructured"
                sling:resourceType="gmrc/groupmember"
                groupID="[group1,group2,group3]"
                declaredOnly="true|false (optional)"
                authorizableID="someID (optional)" />        

groupID allows for multiple groups to be tested for membership, which is essentially a shortcut for using [built-in OR conditions] with several of these render conditions, if you require a user to be members of multiple groups, use the [built-in AND contitions.]

### Defaults

-   declaredOnly – “false”
-   authorizableID – request.getRemoteUser()

### Example

(see <http://localhost:4502/editor.html/content/gmrc.html> to view this code live)
       
    <column jcr:primaryType="nt:unstructured"
        sling:resourceType="granite/ui/components/foundation/container">
        <items jcr:primaryType="nt:unstructured">
            <section
                sling:resourceType="granite/ui/components/foundation/section">
                <layout jcr:primaryType="nt:unstructured"
                    sling:resourceType="granite/ui/components/foundation/layouts/well" />
                <items jcr:primaryType="nt:unstructured">
                    <text cq:showOnCreate="{Boolean}true"
                        jcr:primaryType="nt:unstructured"
                        sling:resourceType="granite/ui/components/foundation/text"
                        text="this text will render for [everyone]. Render condition applied to containing granite/ui/components/foundation/section node.">
                    </text>
                </items>

                <rendercondition jcr:primaryType="nt:unstructured"
                    sling:resourceType="gmrc/groupmember"
                    declaredOnly="false"
                    groupID="[everyone]" />
                    
            </section>
            <section2
                sling:resourceType="granite/ui/components/foundation/section">
                <layout jcr:primaryType="nt:unstructured"
                    sling:resourceType="granite/ui/components/foundation/layouts/well" />
                <items jcr:primaryType="nt:unstructured">
                    <text cq:showOnCreate="{Boolean}true"
                        jcr:primaryType="nt:unstructured"
                        sling:resourceType="granite/ui/components/foundation/text"
                        text="this text will render only for [administrators]. Render condition applied to this granite/ui/components/foundation/text node.">
                        
                        <rendercondition jcr:primaryType="nt:unstructured"
                            sling:resourceType="gmrc/groupmember"
                            declaredOnly="false"
                            groupID="[administrators]" />
                        
                    </text>
                </items>
            </section2>
            <section3
                sling:resourceType="granite/ui/components/foundation/section">
                <layout jcr:primaryType="nt:unstructured"
                    sling:resourceType="granite/ui/components/foundation/layouts/well" />
                <items jcr:primaryType="nt:unstructured">
                    <text cq:showOnCreate="{Boolean}true"
                        jcr:primaryType="nt:unstructured"
                        sling:resourceType="granite/ui/components/foundation/text"
                        text="this text will render only for [somenonexistantgroup] (probably no one!)">
                        
                        <rendercondition jcr:primaryType="nt:unstructured"
                            sling:resourceType="gmrc/groupmember"
                            declaredOnly="false"
                            groupID="[somenonexistantgroup]" />
                            
                    </text>
                </items>
            </section3>
        </items>
    </column>
    
About
-----

By [Ben Stockwell] – May 2016

### Lisence and Liability:

This is released with absolutely no lisence, use at your own risk.

  [Ben Stockwell]: http://scrupulo.com

  [Github Repo]: https://github.com/scrupulo/group-member-render-condition
  [built-in OR conditions]: https://docs.adobe.com/docs/en/aem/6-1/ref/granite-ui/api/jcr_root/libs/granite/ui/components/foundation/renderconditions/or/index.html
  [built-in AND contitions.]: https://docs.adobe.com/docs/en/aem/6-1/ref/granite-ui/api/jcr_root/libs/granite/ui/components/foundation/renderconditions/and/index.html