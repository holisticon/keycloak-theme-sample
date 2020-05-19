<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=social.displayInfo; section>
    <#if section = "title">
        ${msg("loginTitle",(realm.displayName!''))}
    <#elseif section = "header">
        ${msg("loginTitleHtml",(realm.displayNameHtml!''))?no_esc}
    <#elseif section = "form">
        <#if realm.password>
            <form id="form-login" class="kl-form-login" action="${url.loginAction}" method="post">
                <div class="${properties.kcFormGroupClass!} form-group">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>
                    </div>

                    <div>
                        <#if usernameEditDisabled??>
                            <input id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}" type="text" disabled />
                        <#else>
                            <input id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}" type="text" autofocus autocomplete="off" />
                        </#if>
                    </div>
                </div>

                <div class="form-group">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>
                    </div>

                    <div>
                        <input id="password" class="${properties.kcInputClass!}" name="password" type="password" autocomplete="off" />
                    </div>
                </div>


                    <div class="kl-form-options form-group">
                        <#if realm.rememberMe && !usernameEditDisabled??>
                            <div class="checkbox form-group">
                                <div class="multiple-choice">
                                    <#if login.rememberMe??>
                                        <input id="rememberMe" name="rememberMe" type="checkbox" tabindex="3" checked>
                                        <label for="rememberMe" class="${properties.kcCheckboxLabelClass}">${msg("rememberMe")}</label>
                                    <#else>
                                        <input id="rememberMe" name="rememberMe" type="checkbox" tabindex="3">
                                        <label for="rememberMe" class="${properties.kcCheckboxLabelClass}">${msg("rememberMe")}</label>
                                    </#if>
                                </div>
                            </div>
                        </#if>
                    </div>

                    <div class="kl-form-button submit form-group">
                        <div class="${properties.kcFormButtonsWrapperClass!}">
                            <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" name="login" id="kl-login" type="submit" value="${msg("doLogIn")}"/>
                        </div>
                    </div>

                        <div class="${properties.kcFormOptionsWrapperClass!} form-group">
                            <#if realm.resetPasswordAllowed>
                                <p><a href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></p>
                            </#if>
                        </div>
            </form>
        </#if>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !usernameEditDisabled??>
            <div id="kl-registration">
                <h2 class="heading-medium">${msg("noAccount")}</h2>
                <p><a href="${url.registrationUrl}">${msg("registerLink")}</a></p>
            </div>
        </#if>

        <#if realm.password && social.providers??>
            <#-- This section of the theme has not yet been well styled. Non-trivial user research, interaction design and content design work is required to develop a solution for login using 3rd-party identity providers. -->
            <div id="kl-social-providers">
                <h2 class="heading-medium">${msg("socialProviders")}</h2>
                <ul class="list">
                    <#list social.providers as p>
                        <li><a href="${p.loginUrl}" id="zocial-${p.alias}" class="button zocial ${p.providerId}">${p.displayName}</a></li>
                    </#list>
                </ul>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>
