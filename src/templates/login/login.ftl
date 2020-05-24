<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=social.displayInfo; section>
    <#if section = "title">
        ${msg("loginTitle",(realm.displayName!''))}
    <#elseif section = "header">
        ${msg("loginTitleHtml",(realm.displayNameHtml!''))?no_esc}
    <#elseif section = "form">
        <form action="${url.loginAction}" method="post">

            <#if !realm.loginWithEmailAllowed>
                <#if usernameEditDisabled??>
                    <input type="text" data-qa="username" value="${(login.username!'')}" name="username" placeholder="${msg("username")}" class="holi-input-field" readonly />
                <#else>
                    <input type="text" data-qa="username" value="${(login.username!'')}" name="username" placeholder="${msg("username")}" class="holi-input-field" autofocus autocomplete="off" />
                </#if>
            <#elseif !realm.registrationEmailAsUsername>
                <#if usernameEditDisabled??>
                    <input type="text" data-qa="username" value="${(login.username!'')}" name="username" placeholder="${msg("usernameOrEmail")}" class="holi-input-field" readonly />
                <#else>
                    <input type="text" data-qa="username"
                           value="${(login.username!'')}"
                           name="username"
                           id="username"
                           placeholder="${msg("usernameOrEmail")}"
                           class="holi-input-field"
                           autofocus
                           autocomplete="off" />
                    <script type="text/javascript" src="${url.resourcesPath}/vendor/scripts/index.js"></script>
                </#if>
            <#else>
                <#if usernameEditDisabled??>
                    <input type="email" data-qa="email" value="${(login.username!'')}" name="username" placeholder="${msg("email")}" class="holi-input-field" readonly />
                <#else>
                    <input type="email" data-qa="email" value="${(login.username!'')}" name="username" placeholder="${msg("email")}" class="holi-input-field" autofocus autocomplete="off" />
                </#if>
            </#if>

            <input id="password" data-qa="password" class="holi-input-field" name="password" type="password" autocomplete="off" placeholder="${msg("password")}" />

            <!-- hidden + checked remember me checkbox -->
            <input style="display: none;" id="rememberMe" name="rememberMe" type="checkbox" tabindex="-1" checked>

            <#if message?has_content && (message.type == "error" || message.type == "warning")>
                <input class="holi-primary-btn" data-qa="login"
                       name="login"
                       id="kl-login"
                       type="submit"
                       value="${msg("tryAgain")}" />
            <#else>
                <input class="holi-primary-btn" data-qa="login"
                       name="login"
                       id="kl-login"
                       type="submit"
                       value="${msg("doLogIn")}" />
            </#if>
        </form>
    <#elseif section = "footer">

        <#if realm.resetPasswordAllowed>
            <a class="forgot-password-link" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
        </#if>

    <#elseif section = "info">
    <#-- these sections are not used in holisticon context. We will keep them unstyled but functional. -->
        <#if realm.password && realm.registrationAllowed && !usernameEditDisabled??>
            <h2 class="heading-medium">${msg("noAccount")}</h2>
            <p>
                <a href="${url.registrationUrl}">${msg("registerLink")}</a>
            </p>
        </#if>

        <#if realm.password && social.providers??>
        <#--This section of the theme has not yet been well styled. Non-trivial user research, interaction design and content design work is required to develop a solution for login using 3rd-party identity providers. -->
            <div id="kl-social-providers">
                <h2 class="heading-medium">${msg("socialProviders")}</h2>
                <ul class="list">
                    <#list social.providers as p>
                        <li>
                            <a href="${p.loginUrl}" id="zocial-${p.alias}" class="button zocial ${p.providerId}">${p.displayName}</a>
                        </li>
                    </#list>
                </ul>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>
