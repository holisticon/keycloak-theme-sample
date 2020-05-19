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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="robots" content="noindex, nofollow">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title><#nested "title"> - ${realm.displayName!'Holisticon'}</title>

<#-- Start Holisticon Template <head> content -->
    <!--[if IE 6]>
    <link href="${url.resourcesPath}/vendor/css/elements-ie6.css?.0.1.0" media="screen" rel="stylesheet"/>
    <![endif]-->
    <!--[if IE 7]>
    <link href="${url.resourcesPath}/vendor/css/elements-ie7.css?.0.1.0" media="screen" rel="stylesheet"/>
    <![endif]-->
    <!--[if IE 8]>
    <link href="${url.resourcesPath}/vendor/css/elements-ie8.css?.0.1.0" media="screen" rel="stylesheet"/>
    <![endif]-->

    <link href="${url.resourcesPath}/css/fonts.css?.0.1.0" media="all" rel="stylesheet"/><!--<![endif]-->

    <link rel="shortcut icon" href="${url.resourcesPath}/vendor/images/favicon.ico?.0.1.0" type="image/x-icon"/>
    <link rel="apple-touch-icon-precomposed" sizes="152x152"
          href="${url.resourcesPath}/vendor/images/apple-touch-icon-152x152.png?.0.1.0">
    <link rel="apple-touch-icon-precomposed" sizes="120x120"
          href="${url.resourcesPath}/vendor/images/apple-touch-icon-120x120.png?.0.1.0">
    <link rel="apple-touch-icon-precomposed" sizes="76x76"
          href="${url.resourcesPath}/vendor/images/apple-touch-icon-76x76.png?.0.1.0">
    <link rel="apple-touch-icon-precomposed"
          href="${url.resourcesPath}/vendor/images/apple-touch-icon-60x60.png?.0.1.0">

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta property="og:image" content="${url.resourcesPath}/vendor/images/opengraph-image.png?.0.1.0">

<#-- End Holisticon Template <head> content -->


<#-- Holisticon Elements stylesheets -->
    <link href="${url.resourcesPath}/css/base.css" rel="stylesheet" type="text/css">
    <link href="${url.resourcesPath}/css/elements.css" rel="stylesheet" type="text/css">
    <!--[if IE 6]>
    <link href="${url.resourcesPath}/css/elements-ie6.css" rel="stylesheet" type="text/css"/><![endif]-->
    <!--[if IE 7]>
    <link href="${url.resourcesPath}/css/elements-ie7.css" rel="stylesheet" type="text/css"/><![endif]-->
    <!--[if IE 8]>
    <link href="${url.resourcesPath}/css/elements-ie8.css" rel="stylesheet" type="text/css"/><![endif]-->

<#-- End Holisticon Elements stylesheets -->

    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet"/>
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
</head>

<body class="kl-body">

<div id="global-header-bar"></div>

<#-- End Holisticon Template header -->

<div class="kl-logo-wrapper">
    <h1 class="heading-large">
        <a href="${properties.kcLogoLink!'#'}">
            <div class="kl-logo"></div>
        </a>
    </h1>
</div>

<main id="content" class="kl-main-wrapper" role="main">

    <div class="kl-back-wrapper"><#nested "back"></div>

    <div class="grid-row">
        <div class="column-two-thirds">
            <div class="row kl-container-wrapper">
                <div class="kl-container">

                    <!-- FIXME: Support l18n
                        <#if realm.internationalizationEnabled>
                            <div id="kl-locale" class="${properties.kcLocaleClass!}">
                                <div id="kl-locale-wrapper" class="${properties.kcLocaleWrapperClass!}">
                                    <div class="kl-dropdown" id="kl-locale-dropdown">
                                        <a href="#" id="kl-current-locale-link">${locale.current}</a>
                                        <ul>
                                            <#list locale.supported as l>
                                                <li class="kl-dropdown-item"><a href="${l.url}">${l.label}</a></li>
                                            </#list>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </#if>
                       -->
                    <div id="kl-content" class="${properties.kcContentClass!}">
                        <div id="kl-content-wrapper" class="${properties.kcContentWrapperClass!}">

                                <#if displayMessage && message?has_content>
                                    <#if message.type = 'error'>
                                        <div class="error-summary" role="group"
                                             aria-labelledby="error-summary-heading-example-1" tabindex="-1">
                                            <h1 class="heading-medium error-summary-heading"
                                                id="error-summary-heading-example-1">
                                                ${msg("errorTitle")}
                                            </h1>

                                            <ul class="error-summary-list" id="error-details">
                                                <li>${message.summary}</li>
                                            </ul>
                                        </div>
                                    <#else>
                                        <div class="${properties.kcFeedbackAreaClass!}">
                                            <div class="alert alert-${message.type}"><p>
                                                <#if message.type = 'success'><span
                                                        class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
                                                <#if message.type = 'warning'><span
                                                        class="${properties.kcFeedbackWarningIcon!}"></span></#if>
                                                <#if message.type = 'info'><span
                                                        class="${properties.kcFeedbackInfoIcon!}"></span></#if>
                                                <span class="kl-feedback-text">${message.summary}</span></p>
                                            </div>
                                        </div>
                                    </#if>
                                </#if>

                            <div id="kl-form" class="${properties.kcFormAreaClass!}">
                                <div id="kl-form-wrapper" class="${properties.kcFormAreaWrapperClass!}">
                                        <#nested "form">
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="column-one-third">
                <#if displayInfo>
                    <div id="kl-info" class="${properties.kcInfoAreaClass!}">
                        <div id="kl-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                            <#nested "info">
                        </div>
                    </div>
                </#if>
        </div>
    </div>

    <div class="kl-cookie-message">

        <p>Wir nutzen Cookies. <a target="_blank" href="${properties.kcPrivacyLink}">Finde mehr über die Verwendung von Cookies heraus.</a></p>

    </div>
</main>

<#-- Start Holisticon Template footer -->

<footer class="navbar-fixed-bottom js-footer" id="footer" role="contentinfo">

    <div class="footer-wrapper">
        <div class="footer-meta">
            <div class="copyright">
                &copy; 2018 Holisticon
                <br>
                Beste Beratung. Beste Software.
            </div>
        </div>
    </div>
</footer>

<div id="global-app-error" class="app-error hidden"></div>
</body>
</html>
</#macro>
