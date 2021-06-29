<#macro htmlEmailLayout>
<html>
<head>
</head>
<body text="#000000" bgcolor="#FFFFFF">
<#if realmName??>
<table width="100%" bgcolor="#000000" cellspacing="0" cellpadding="15"><tr><td>
<font style="font-size:24px;" size="5" color="#FFFFFF"><b>
${realmName}
</b></font>
</td></tr></table>
</#if>

<#nested "text">

<#if link??>
<table class="button" bgcolor="#00823B" cellspacing="0" cellpadding="10"><tr><td>
<a href="${link}"><font style="font-size:19px;" size="4" color="#FFFFFF"><#nested "linkText"></font></a>
</td></tr></table>
</#if>

</body>
</html>
</#macro>
