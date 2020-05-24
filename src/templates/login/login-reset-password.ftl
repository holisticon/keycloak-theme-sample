<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "title">
        ${msg("emailForgotTitle")}
    <#elseif section = "header">
        ${msg("emailForgotTitle")}
    <#elseif section = "back">
        <a class="link-back" href="${url.loginUrl}">
            <i class="holi-icon-arrow_back"></i>
            ${msg("backToLogin")}
        </a>
    <#elseif section = "form">
        ${msg("emailInstruction")}

        <form id="kc-reset-password-form" action="${url.loginAction}" method="post">

            <#if !realm.loginWithEmailAllowed>
                <input type="text" id="username" name="username" placeholder="${msg("username")}" class="holi-input-field" autofocus/>
            <#elseif !realm.registrationEmailAsUsername>
                <input type="text" id="username" name="username" placeholder="${msg("usernameOrEmail")}" class="holi-input-field" autofocus/>
            <#else>
                <input type="text" id="username" name="username" placeholder="${msg("email")}" class="holi-input-field" autofocus/>
            </#if>

            <input class="holi-primary-btn" type="submit" value="${msg("doResetPassword")}"/>
        </form>
    </#if>
</@layout.registrationLayout>
