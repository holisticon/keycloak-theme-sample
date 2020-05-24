<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true>
    <!DOCTYPE html>

    <#-- Attempt to reverse-engineer code for page’s current language, as Keycloak does not currently make this available -->
    <#assign LANG_CODE = "en">
    <#if .locale??>
        <#assign LANG_CODE = .locale>
    </#if>
    <#if locale??>
        <#list locale.supported>
            <#items as supportedLocale>
                <#if supportedLocale.label == locale.current>
                    <#if supportedLocale.url?contains("?kc_locale=")>
                        <#assign LANG_CODE = supportedLocale.url?keep_after("?kc_locale=")[0..1]>
                    </#if>
                    <#if supportedLocale.url?contains("&kc_locale=")>
                        <#assign LANG_CODE = supportedLocale.url?keep_after("&kc_locale=")[0..1]>
                    </#if>
                </#if>
            </#items>
        </#list>
    </#if>

    <!--[if lt IE 9]>
    <html class="lte-ie8 ${properties.kcHtmlClass!}" lang="${LANG_CODE}"><![endif]-->
    <!--[if gt IE 8]><!-->
    <html class="${properties.kcHtmlClass!}" lang="${LANG_CODE}"><!--<![endif]-->

    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="robots" content="noindex, nofollow">

        <#if properties.meta?has_content>
            <#list properties.meta?split(' ') as meta>
                <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}" />
            </#list>
        </#if>
        <title><#nested "title"> - ${realm.displayName!'Holisticon'}</title>

        <link rel="shortcut icon" href="${url.resourcesPath}/images/favicon.ico?.0.1.0" type="image/x-icon" />
        <link rel="apple-touch-icon-precomposed" sizes="152x152"
              href="${url.resourcesPath}/images/apple-touch-icon-152x152.png?.0.1.0">
        <link rel="apple-touch-icon-precomposed" sizes="120x120"
              href="${url.resourcesPath}/images/apple-touch-icon-120x120.png?.0.1.0">
        <link rel="apple-touch-icon-precomposed" sizes="76x76"
              href="${url.resourcesPath}/images/apple-touch-icon-76x76.png?.0.1.0">
        <link rel="apple-touch-icon-precomposed"
              href="${url.resourcesPath}/images/apple-touch-icon-60x60.png?.0.1.0">

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta property="og:image" content="${url.resourcesPath}/images/opengraph-image.png?.0.1.0">

        <#-- End Holisticon Template <head> content -->


        <#if properties.styles?has_content>
            <#list properties.styles?split(' ') as style>
                <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
            </#list>
        </#if>
        <#if properties.scripts?has_content>
            <#list properties.scripts?split(' ') as script>
                <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
            </#list>
        </#if>
        <#if scripts??>
            <#list scripts as script>
                <script src="${script}" type="text/javascript"></script>
            </#list>
        </#if>
       <script src="${url.resourcesPath}/js/bundle.js" type="text/javascript"></script>
    </head>


    <body>
    <main>
        <#-- https://freemarker.apache.org/docs/dgui_template_exp.html -->
        <div class="keycloak-back">
            <#nested "back">
        </div>
        <div class="keycloak-window ${(message.type)!""}" style="${additionalWindowsContainerStyle!}">
            <div class="keycloak-header">
                <img src="${url.resourcesPath}/images/logo_final1.png"
                     srcset="${url.resourcesPath}/images/logo_final1.png 1x, ${url.resourcesPath}/images/logo_final1@2x.png 2x"
                     class="logo" />
            </div>
            <div class="keycloak-body">

                <#if displayMessage && message?has_content>
                    <div class="messages">
                        <#--types: error success warning info -->
                        <span class="${message.type}">${message.summary?no_esc}</span>
                    </div>
                </#if>

                <#nested "info">
                <#nested "form">
            </div>
        </div>
        <div class="keycloak-footer">
            <div class="left">
                <#nested "footer">
            </div>
            <div class="right">
                <a href="https://holisticon.de/impressum.html#data-protection">Privacy Policy</a>
            </div>
        </div>
    </main>

    </body>


    <#--<body class="kl-body">-->

    <#--<div id="global-header-bar"></div>-->

    <#--&lt;#&ndash; End Holisticon Template header &ndash;&gt;-->

    <#--<div class="kl-logo-wrapper">-->
    <#--<h1 class="heading-large">-->
    <#--<a href="${properties.kcLogoLink!'#'}">-->
    <#--<div class="kl-logo"></div>-->
    <#--</a>-->
    <#--</h1>-->
    <#--</div>-->

    <#--<main id="content" class="kl-main-wrapper" role="main">-->

    <#--<div class="kl-back-wrapper"><#nested "back"></div>-->

    <#--<div class="grid-row">-->
    <#--<div class="column-two-thirds">-->
    <#--<div class="row kl-container-wrapper">-->
    <#--<div class="kl-container">-->

    <#--<!-- FIXME: Support l18n-->
    <#--<#if realm.internationalizationEnabled>-->
    <#--<div id="kl-locale" class="${properties.kcLocaleClass!}">-->
    <#--<div id="kl-locale-wrapper" class="${properties.kcLocaleWrapperClass!}">-->
    <#--<div class="kl-dropdown" id="kl-locale-dropdown">-->
    <#--<a href="#" id="kl-current-locale-link">${locale.current}</a>-->
    <#--<ul>-->
    <#--<#list locale.supported as l>-->
    <#--<li class="kl-dropdown-item"><a href="${l.url}">${l.label}</a></li>-->
    <#--</#list>-->
    <#--</ul>-->
    <#--</div>-->
    <#--</div>-->
    <#--</div>-->
    <#--</#if>-->
    <#--&ndash;&gt;-->
    <#--<div id="kl-content" class="${properties.kcContentClass!}">-->
    <#--<div id="kl-content-wrapper" class="${properties.kcContentWrapperClass!}">-->



    <#--<div id="kl-form" class="${properties.kcFormAreaClass!}">-->
    <#--<div id="kl-form-wrapper" class="${properties.kcFormAreaWrapperClass!}">-->
    <#--<#nested "form">-->
    <#--</div>-->
    <#--</div>-->

    <#--</div>-->
    <#--</div>-->
    <#--</div>-->
    <#--</div>-->
    <#--</div>-->

    <#--<div class="column-one-third">-->
    <#--<#if displayInfo>-->
    <#--<div id="kl-info" class="${properties.kcInfoAreaClass!}">-->
    <#--<div id="kl-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">-->
    <#--<#nested "info">-->
    <#--</div>-->
    <#--</div>-->
    <#--</#if>-->
    <#--</div>-->
    <#--</div>-->

    <#--<div class="kl-cookie-message">-->

    <#--<p>Wir nutzen Cookies.-->
    <#--<a target="_blank" href="${properties.kcPrivacyLink}">Finde mehr über die Verwendung von Cookies heraus.</a>-->
    <#--</p>-->

    <#--</div>-->
    <#--</main>-->

    <#--&lt;#&ndash; Start Holisticon Template footer &ndash;&gt;-->

    <#--<footer class="navbar-fixed-bottom js-footer" id="footer" role="contentinfo">-->

    <#--<div class="footer-wrapper">-->
    <#--<div class="footer-meta">-->
    <#--<div class="copyright">-->
    <#--&copy; 2018 Holisticon-->
    <#--<br>-->
    <#--Beste Beratung. Beste Software.-->
    <#--</div>-->
    <#--</div>-->
    <#--</div>-->
    <#--</footer>-->

    <#--<div id="global-app-error" class="app-error hidden"></div>-->
    <#--</body>-->
    </html>
</#macro>
