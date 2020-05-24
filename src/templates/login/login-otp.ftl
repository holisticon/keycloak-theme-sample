<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "title">
        ${msg("loginTitle",realm.displayName)}
    <#elseif section = "header">
        ${msg("loginTitleHtml",realm.displayNameHtml)?no_esc}
    <#elseif section = "form">

        <form id="kc-totp-login-form" action="${url.loginAction}" method="post">

            <input id="otp" name="otp" data-qa="otp" autocomplete="off" type="text" class="holi-input-field" autofocus placeholder="${msg("loginTotpOneTime")}" />

            <input class="holi-primary-btn" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}" />

        </form>

    </#if>
</@layout.registrationLayout>
