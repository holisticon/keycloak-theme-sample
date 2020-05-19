<#macro mainLayout active bodyClass>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">

    <title>${msg("accountManagementTitle")}</title>


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

    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico">
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script type="text/javascript" src="${url.resourcesPath}/${script}"></script>
        </#list>
    </#if>
</head>
<body class="admin-console user ka-body">

    <header class="navbar navbar-default navbar-pf navbar-main header ka-header">
        <nav class="navbar ka-navbar" role="navigation">
            <div class="navbar-collapse navbar-collapse-1">
                <div class="container">
                    <ul class="nav navbar-nav navbar-utility">
                        <#if realm.internationalizationEnabled>
                            <li>
                                <div class="kc-dropdown" id="kc-locale-dropdown">
                                    <a href="#" id="kc-current-locale-link">${locale.current}</a>
                                    <ul>
                                        <#list locale.supported as l>
                                            <li class="kc-dropdown-item"><a href="${l.url}">${l.label}</a></li>
                                        </#list>
                                    </ul>
                                </div>
                            <li>
                        </#if>
                        <#if referrer?has_content && referrer.url?has_content><li><a href="${referrer.url}" id="referrer">${msg("backTo",referrer.name)}</a></li></#if>
                        <li><a href="${url.logoutUrl}">${msg("doSignOut")}</a></li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <div class="container ka-container">
        <div class="ka-sidebar bs-sidebar col-sm-3">
            <ul>
                <li class="<#if active=='account'>active</#if>"><a href="${url.accountUrl}">${msg("account")}</a></li>
                <#if features.passwordUpdateSupported><li class="<#if active=='password'>active</#if>"><a href="${url.passwordUrl}">${msg("password")}</a></li></#if>
                <li class="<#if active=='totp'>active</#if>"><a href="${url.totpUrl}">${msg("authenticator")}</a></li>
                <#if features.identityFederation><li class="<#if active=='social'>active</#if>"><a href="${url.socialUrl}">${msg("federatedIdentity")}</a></li></#if>
                <li class="<#if active=='sessions'>active</#if>"><a href="${url.sessionsUrl}">${msg("sessions")}</a></li>
                <li class="<#if active=='applications'>active</#if>"><a href="${url.applicationsUrl}">${msg("applications")}</a></li>
                <#if features.log><li class="<#if active=='log'>active</#if>"><a href="${url.logUrl}">${msg("log")}</a></li></#if>
                <#if realm.userManagedAccessAllowed && features.authorization><li class="<#if active=='authorization'>active</#if>"><a href="${url.resourceUrl}">${msg("myResources")}</a></li></#if>
            </ul>
        </div>

        <div class="ka-content-area col-sm-9 content-area">
            <#if message?has_content>
                <div class="alert alert-${message.type}">
                    <#if message.type=='success' ><span class="pficon pficon-ok"></span></#if>
                    <#if message.type=='error' ><span class="pficon pficon-error-octagon"></span><span class="pficon pficon-error-exclamation"></span></#if>
                    ${kcSanitize(message.summary)?no_esc}
                </div>
            </#if>

            <#nested "content">
        </div>
    </div>

</body>
</html>
</#macro>
