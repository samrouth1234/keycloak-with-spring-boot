<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        <div class="font-header">បង្កើតទម្រង់លិខិតដែលមានសុវត្ថិភាពខ្ពស់</br><div class="font-header-in ">ក្នុងរយៈពេលដ៏ខ្លី</div> </div>
    <#elseif section = "form">
        <div id="kc-form">
            <div id="kc-form-wrapper">
                <p class="description-login">ចូលទៅកាន់គណនី .gov.kh ឬអាសយដ្ឋានអ៊ីម៉ែលដែលត្រូវបានអនុញ្ញាត</p>
                <#if realm.password>
                    <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                        <div class="${properties.kcFormGroupClass!}">
                            <label for="username" class="${properties.kcLabelClass!}"><span class="text-size-style">អ៊ីមែល</span></label>
                            <#if usernameEditDisabled??>
                                <input tabindex="1" id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}" type="text" disabled/>
                            <#else>
                                <input tabindex="1" id="username"  placeholder="e.g example@gov.kh"  class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}"
                                       type="text" autofocus autocomplete="off" aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                />
                                <#if messagesPerField.existsError('username','password')>
                                    <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                        </span>
                                </#if>
                            </#if>
                        </div>

                        <div class="${properties.kcFormGroupClass!}">
                            <label for="password" class="${properties.kcLabelClass!}"><span class="text-size-style">${msg("លេខសម្ងាត់")}</span></label>
                            <div class="password-wrapper">
                                <input tabindex="2" id="password" class="${properties.kcInputClass!}" name="password"
                                       type="password" autocomplete="off" aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"/>
                                <div class="toggle-password " data-toggle="password">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-eye-fill" viewBox="0 0 16 16">
                                        <path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0"/>
                                        <path d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8m8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7"/>
                                    </svg>
                                </div>
                            </div>
                        </div>

                        <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                            <div id="kc-form-options">
                                <#if realm.rememberMe && !usernameEditDisabled??>
                                    <div class="checkbox">
                                        <label>
                                            <#if login.rememberMe??>
                                                <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("ចំណាំទុក")}
                                            <#else>
                                                <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> <span class="text-size-style">${msg("ចំណាំទុក")}</span>
                                            </#if>
                                        </label>
                                    </div>
                                </#if>
                            </div>
                            <div class="${properties.kcFormOptionsWrapperClass!}">
                                <#if realm.resetPasswordAllowed>
                                    <a tabindex="5" class="text-size-forgot-password-style" href="${url.loginResetCredentialsUrl}">${msg("ភ្លេចពាក្យសម្ងាត់?")}</a>
                                </#if>
                            </div>
                        </div>

                        <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                            <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                            <input tabindex="4" class="text-size-login-style" name="login" id="kc-login" type="submit" value="${msg("ចូលគណនី")}"/>
                        </div>
                    </form>
                </#if>
            </div>

            <#if realm.password && social.providers??>
                <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                    <hr/>
                    <h4>${msg("identity-provider-login-label")}</h4>
                    <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                        <#list social.providers as p>
                            <a id="social-${p.alias}" class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>" type="button" href="${p.loginUrl}">
                                <#if p.iconClasses?has_content>
                                    <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                    <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                                <#else>
                                    <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                                </#if>
                            </a>
                        </#list>
                    </ul>
                </div>
            </#if>
        </div>
        <script>
            document.querySelectorAll('.toggle-password').forEach(item => {
                item.addEventListener('click', event => {
                    const input = document.getElementById(item.getAttribute('data-toggle'));
                    const icon = item;
                    if (input.type === 'password') {
                        input.type = 'text';
                        icon.innerHTML = `
              <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-eye-slash-fill" viewBox="0 0 16 16">
                  <path d="m10.79 12.912-1.614-1.615a3.5 3.5 0 0 1-4.474-4.474l-2.06-2.06C.938 6.278 0 8 0 8s3 5.5 8 5.5a7 7 0 0 0 2.79-.588M5.21 3.088A7 7 0 0 1 8 2.5c5 0 8 5.5 8 5.5s-.939 1.721-2.641 3.238l-2.062-2.062a3.5 3.5 0 0 0-4.474-4.474z"/>
                  <path d="M5.525 7.646a2.5 2.5 0 0 0 2.829 2.829zm4.95.708-2.829-2.83a2.5 2.5 0 0 1 2.829 2.829zm3.171 6-12-12 .708-.708 12 12z"/>
              </svg>`;
                    } else {
                        input.type = 'password';
                        icon.innerHTML = `
              <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-eye-fill" viewBox="0 0 16 16">
                 <path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0"/>
                 <path d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8m8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7"/>
              </svg>`;
                    }
                });
            });
        </script>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container">
                <div id="kc-registration">
                    <p><span class="not-account">${msg("មិនមានគណនី?")}</span><a tabindex="6" class="color-style" href="${url.registrationUrl}">${msg("ចូលបង្កើតគណនី")}</a></p>
                </div>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>