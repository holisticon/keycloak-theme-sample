<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
  <#if section = "title">
    ${msg("loginTotpTitle")}
  <#elseif section = "header">
    ${msg("loginTotpTitle")}
  <#elseif section = "form">

    <ol class="login-config-totp">
      <li>
        <p>${msg("loginTotpStep1")}</p>
      </li>
      <li>
        <p>
          ${msg("loginTotpStep2")}
          <img id="kc-totp-secret-qr-code" src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Figure: Barcode"><br />
          <span class="code">${totp.totpSecretEncoded}</span>
        </p>
      </li>
      <li>
        <p>${msg("loginTotpStep3")}</p>
      </li>
    </ol>
    <form action="${url.loginAction}" id="kc-totp-settings-form" method="post">
      <input type="text" id="totp" name="totp" autocomplete="off" class="holi-input-field" autofocus placeholder="${msg("loginTotpOneTime")}"/>
      <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />

      <input class="holi-primary-btn" type="submit" value="${msg("doSubmit")}" />
    </form>
  </#if>
</@layout.registrationLayout>
