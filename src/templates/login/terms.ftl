
<#global additionalWindowsContainerStyle = "width:80%;margin: auto;">
<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage=false; section>
    <#if section = "title">
    ${msg("termsTitle")}
    <#elseif section = "header">
    ${msg("termsTitleHtml")?no_esc}
    <#elseif section = "form">
    <p>${msg("termsIntro")}</p>
    
    <div id="kc-terms-text" class="panel panel-border-wide">
        ${msg("termsText")?no_esc}
    </div>
    <div id="kc-terms-text" class="panel panel-border-wide">
        ${msg("termsTextHtml")?no_esc}
    </div>
    
    <form class="form-actions" action="${url.loginAction}" method="POST">
        <input class="holi-primary-btn" name="accept" id="kc-accept" type="submit" value="${msg("doAccept")}"/>
    </form>
    </#if>
</@layout.registrationLayout>
