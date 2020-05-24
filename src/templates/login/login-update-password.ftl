<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
  <#if section = "header">
    ${msg("updatePasswordTitle")}
  <#elseif section = "form">
    <form id="kc-passwd-update-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
      <#--<input type="hidden" id="username" name="username" value="${username}" readonly="readonly"/>-->
      <#--<input type="password" id="password" name="password" autocomplete="current-password" style="display:none;"/>-->

      <input type="password" id="password-new" name="password-new" class="holi-input-field" autofocus autocomplete="new-password" placeholder="${msg("passwordNew")}" />

      <input type="password" id="password-confirm" name="password-confirm" class="holi-input-field" autocomplete="new-password" placeholder="${msg("passwordConfirm")}" />

      <input class="holi-primary-btn" type="submit" value="${msg("doSubmit")}" />
    </form>
  </#if>
</@layout.registrationLayout>
