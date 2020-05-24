<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
  <#if section = "header">
    ${msg("loginProfileTitle")}
  <#elseif section = "form">
    <form id="kc-update-profile-form" action="${url.loginAction}" method="post">

      <#if user.editUsernameAllowed>
        <input type="text"
               id="username"
               name="username"
               value="${(user.username!'')}"
               class="holi-input-field ${messagesPerField.printIfExists('username', 'error')}"
               autofocus
               placeholder="${msg("username")}" />
      </#if>

      <input type="text"
             id="email"
             name="email"
             value="${(user.email!'')}"
             class="holi-input-field ${messagesPerField.printIfExists('email', 'error')}"
             placeholder="${msg("email")}" />

      <input type="text"
             id="firstName"
             name="firstName"
             value="${(user.firstName!'')}"
             class="holi-input-field ${messagesPerField.printIfExists('firstName', 'error')}"
             placeholder="${msg("firstName")}" />

      <input type="text"
             id="lastName"
             name="lastName"
             value="${(user.lastName!'')}"
             class="holi-input-field ${messagesPerField.printIfExists('lastName', 'error')}"
             placeholder="${msg("lastName")}" />

      <input class="holi-primary-btn" type="submit" value="${msg("doSubmit")}" />
    </form>
  </#if>
</@layout.registrationLayout>
