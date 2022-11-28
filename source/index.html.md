---
title: Zepto API
language_tabs:
  - shell: Shell
  - ruby: Ruby
  - javascript--node: NodeJS
  - python: Python
  - java: Java
  - php: PHP
  - go: Go
toc_footers: []
includes: []
search: true
highlight_theme: darkula
headingLevel: 2

---

<h1 id="Zepto-API">Zepto API v1.0</h1>

> Scroll down for code samples, example requests and responses. Select a language for code samples from the tabs above or the mobile navigation menu.

Zepto allows you to make, get and manage payments using nothing but bank accounts.

It is important to understand that there are 2 main ways Zepto can be used for maximum flexibility:

1. Between Zepto accounts.
2. Between a Zepto account and anyone.

Due to the above, certain endpoints and techniques will differ slightly depending on who you are interacting with. You can find more on this in the [Making payments](/#making-payments) and [Getting paid](/#getting-paid) guides.

And for all kinds of How To's and Recipes, head on over to our [Help Guide](https://help.split.cash/en/).
<div class="middle-header">Conventions</div>

* Authentication is performed using OAuth2. See the [Get started](/#get-started) and [Authentication & Authorisation](/#authentication-and-authorisation) guides for more.
* All communication is via `https` and supports **only** `TLSv1.2`.
* Production API: `https://api.split.cash/`.
* Production UI: `https://go.split.cash/`.
* Sandbox API: `https://api.sandbox.split.cash/`.
* Sandbox UI: `https://go.sandbox.split.cash/`.
* Data is sent and received as JSON.
* Clients should include the `Accepts: application/json` header in their requests.
* Currencies are represented by 3 characters as defined in [ISO 4217](http://www.xe.com/iso4217.php).
* Dates & times are returned in UTC using [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format with second accuracy. With requests, when no TZ is supplied, the configured TZ of the authenticated user is used, or `Australia/Sydney` if no TZ is configured.
* Amounts are always in cents with no decimals unless otherwise stated.
* Zepto provides static public IP addresses for all outbound traffic, including webhooks.
    * Sandbox IP: `13.237.142.60`
    * Production IPs: `52.64.11.67` and `13.238.78.114`

<div class="middle-header">System Status</div>

Check the platform status, or subscribe to receive notifications at [status.split.cash](https://status.split.cash/). If you would like to check platform status programmatically, please refer to [status.split.cash/api](https://status.split.cash/api).

<div class="middle-header">Breaking Changes</div>

A breaking change is assumed to be:

* Renaming a parameter (request/response)
* Removing a parameter (request/response)
* Changing a parameter type (request/response)
* Renaming a header (request/response)
* Removing a header (request/response)
* Application of stricter validation rules for request parameters
* Reducing the set of possible enumeration values for a request
* Changing a HTTP response status code

We take backwards compatibility very seriously, and will make every effort to ensure this never changes. In the unfortunate (and rare) case where a breaking change can not be avoided, these will be announced well in advance, enabling a transition period for API consumers.

The following are not assumed to be a breaking change and must be taken into account by API consumers:

* Addition of optional new parameters in request
* Addition of new parameters in response
* Addition of new headers in request
* Reordering of parameters in response
* Softening of validation rules for request parameters
* Increasing the set of possible enumeration values

In the case of non breaking changes, a transition period may not be provided, meaning the possibility of such changes occurring must be considered in consumers' logic so as not to break any integrations with both API and Webhooks.

# Guides

## Try it out
The best way to familiarise yourself with our API is by interacting with it.

We've preloaded a collection with all our endpoints for you to use in Postman. Before you start, **import a copy** of our API collection:

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/3168734-baa5ff70-4bc2-44d5-9ba6-fcb61839ff41?action=collection%2Ffork&collection-url=entityId%3D3168734-baa5ff70-4bc2-44d5-9ba6-fcb61839ff41%26entityType%3Dcollection%26workspaceId%3D6400ea2b-bb46-421e-a88c-a8625653c35a#?env%5BSplit%20Payments%20Public%20Sandbox%5D=W3sia2V5Ijoic2l0ZV9ob3N0IiwidmFsdWUiOiJodHRwczovL2dvLnNhbmRib3guc3BsaXQuY2FzaCIsImVuYWJsZWQiOnRydWV9LHsia2V5IjoiYXBpX2hvc3QiLCJ2YWx1ZSI6Imh0dHBzOi8vYXBpLnNhbmRib3guc3BsaXQuY2FzaCIsImVuYWJsZWQiOnRydWV9LHsia2V5Ijoib2F1dGgyX2FwcGxpY2F0aW9uX2lkIiwidmFsdWUiOiIiLCJlbmFibGVkIjp0cnVlfSx7ImtleSI6Im9hdXRoMl9zZWNyZXQiLCJ2YWx1ZSI6IiIsImVuYWJsZWQiOnRydWV9LHsia2V5Ijoic2NvcGUiLCJ2YWx1ZSI6InB1YmxpYyBhZ3JlZW1lbnRzIGJhbmtfYWNjb3VudHMgYmFua19jb25uZWN0aW9ucyBjb250YWN0cyBwYXltZW50cyBwYXltZW50X3JlcXVlc3RzIHJlZnVuZF9yZXF1ZXN0cyB0cmFuc2FjdGlvbnMgcmVmdW5kcyBvcGVuX2FncmVlbWVudHMgb2ZmbGluZV9hY2Nlc3MiLCJlbmFibGVkIjp0cnVlfSx7ImtleSI6Imlzbzg2MDFfbm93IiwidmFsdWUiOiIiLCJlbmFibGVkIjp0cnVlfSx7ImtleSI6ImFjY2Vzc190b2tlbiIsInZhbHVlIjoiIiwiZW5hYmxlZCI6dHJ1ZX0seyJrZXkiOiJyZWZyZXNoX3Rva2VuIiwidmFsdWUiOiIiLCJlbmFibGVkIjp0cnVlfV0=)

Okay, let's get things setup!

1. **Create a Zepto account**

    If you haven't already, you'll want to create a sandbox Zepto account at [https://go.sandbox.split.cash](https://go.sandbox.split.cash)

2. **Register your application with Zepto**

    Sign in and create an OAuth2 application: [https://go.sandbox.split.cash/oauth/applications](https://go.sandbox.split.cash/oauth/applications).

    [![Zepto OAuth2 app create](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/split_oauth2_app_create.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/split_oauth2_app_create.png)

3. **Generate personal access tokens**

    The quickest way to access your Zepto account via the API is using
    personal access tokens. Click on your newly created application from your [application
list](https://go.sandbox.split.cash/oauth/applications) and click on **+ Personal Access Token**.

    [![Zepto locate personal OAuth2 tokens](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/split_personal_access_tokens_empty.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/split_personal_access_tokens_empty.png)

    _(You'll have the option to give the token a title)_

    [![Zepto personal OAuth2 tokens](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/split_personal_access_token.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/split_personal_access_token.png)

    <aside class="notice">Please note that personal access tokens do not expire.</aside>

4. **Use personal access token in Postman**

    You can use this `access_token` to authorise any requests to the
    Zepto API in Postman by choosing the **Bearer Token** option under
    the **Authorization** tab.

    [![Postman use personal OAuth2 tokens](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/postman_use_personal_access_token.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/postman_use_personal_access_token.png)

5. **Make an API request!**

    You are now ready to interact with your Zepto account via the
    API! Go ahead and send a request using Postman.

    [![Postman use personal OAuth2 tokens](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/postman_request_response.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/postman_request_response.png)

## Get started
This guide will help you setup an OAuth2 app in order to get authenticated & authorised to communicate with the Zepto API.

**Before you start:**

* We use the term **user** below but the user can be a third party or the same user that owns the OAuth2 application.
* As noted below, some access tokens expire every 2 hours. To get a new access token use the [refresh grant strategy](/#authentication-and-authorisation) to swap a refresh token for a new access token.

1. **Create a Zepto account**

    If you haven't already, you'll want to create a sandbox Zepto account at [https://go.sandbox.split.cash](https://go.sandbox.split.cash).

2. **Choose authentication method**

    All requests to the Zepto API require an `access_token` for authentication. There are two options for obtaining these tokens, the correct option will depend on your use case:

    **Personal access token** If you only need to access your own Zepto account via the API, then using personal access tokens are the most straight-forward way. Refer to [Personal access token](/#personal-access-token) to setup. These tokens do not expire so no refreshing is required.

    **OAuth grant flow** When you require your application to act on behalf of other Zepto accounts you'll need to implement the OAuth grant flow process. Refer to [OAuth grant flow guide](/#oauth-grant-flow) to setup. There is also an [OAuth grant flow tutorial](/#oauth-grant-flow-tutorial). These access tokens expire every 2 hours, unless the `offline_access` scope is used in which case the tokens will not expire.

## Personal access token
If you're looking to only access your own account via the API, you can generate a personal access token from the UI. These tokens do not expire, but can be deleted.

* To do this, sign in to your Zepto account and [create an application](https://go.sandbox.split.cash/oauth/applications) if you haven't already. Click on your application from your [application list](https://go.sandbox.split.cash/oauth/applications) and click on **Personal access**.

    [![Zepto locate personal OAuth2 tokens](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/split_personal_access_tokens_empty.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/split_personal_access_tokens_empty.png)

    _(You'll have the option to give the token a title)_

    [![Zepto personal OAuth2 tokens](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/split_personal_access_token.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/split_personal_access_token.png)

* Now that you have an `access_token` you can interact with your Zepto account via the API.

    To do so, you must simply append the access token to the header of any API request: `Authorization: Bearer {access_token}`

## OAuth grant flow
1. **Register your application with Zepto**

    Once you've got your account up and running, sign in and create an OAuth2 profile for your application: [https://go.sandbox.split.cash/oauth/applications](https://go.sandbox.split.cash/oauth/applications)

    | Parameter | Description |
    |-----------|-------------|
    | **Name**  | The name of your application. When using the the *Authorisation Grant Flow*, users will see this name as the application requesting access to their account. |
    | **Redirect URI** | Set this to your application's endpoint charged with receiving the authorisation code. |

2. **Obtain an authorisation code**

    Construct the initial URL the user will need to visit in order to grant your application permission to act on his/her behalf. The constructed URL describes the level of permission ([`scope`](/#scopes)), the application requesting permission (`client_id`) and where the user gets redirected once they've granted permission (`redirect_uri`).

    The URL should be formatted to look like this:
    `https://go.sandbox.split.cash/oauth/authorize?response_type=code&client_id={client_id}&redirect_uri={redirect_uri}&scope={scope}`

    | Parameter | Description |
    |-----------|-------------|
    | `response_type` | Always set to `code` |
    | `client_id` | This is your `Application ID` as generated when you registered your application with Zepto |
    | `redirect_uri` | URL where the user will get redirected along with the newly generated authorisation code |
    | `scope` | The [scope](/#scopes) of permission you're requesting |

3. **Exchange the authorisation code for an access token**

    When the user visits the above-mentioned URL, they will be presented with a Zepto login screen and then an authorisation screen:

    [![Authorise OAuth2 app](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/zepto_oauth2_authorize.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/zepto_oauth2_authorize.png)

    After the user has authorised your application, they will be returned to your application at the URL specified in `redirect_uri` along with the `code` query parameter as the authorisation code.

    Finally, the authorisation code can then be exchanged for an access token and refresh token pair by POSTing to: `https://go.sandbox.split.cash/oauth/token`

    **Note** The authorisation code is a ONE-TIME use code. It will not work again if you try to POST it a second time.

    | Parameter | Description |
    |-----------|-------------|
    | `grant_type` | Set to `authorization_code` |
    | `client_id` | This is your `Application ID` as generated when you registered your application with Zepto |
    | `client_secret` | This is your `Secret` as generated when you registered your application with Zepto |
    | `code` | The authorisation code returned with the user (ONE-TIME use) |
    | `redirect_uri` | Same URL used in step 3 |

4. **Wrap-up**

    Now that you have an access token and refresh token, you can interact with the Zepto API as the user related to the access token.
    To do so, you must simply append the access token to the header of any API request: `Authorization: Bearer {access_token}`

## OAuth grant flow tutorial
The OAuth grant flow process is demonstrated using Postman in the steps below.

Before you start, load up our API collection:

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/3168734-baa5ff70-4bc2-44d5-9ba6-fcb61839ff41?action=collection%2Ffork&collection-url=entityId%3D3168734-baa5ff70-4bc2-44d5-9ba6-fcb61839ff41%26entityType%3Dcollection%26workspaceId%3D6400ea2b-bb46-421e-a88c-a8625653c35a#?env%5BSplit%20Payments%20Public%20Sandbox%5D=W3sia2V5Ijoic2l0ZV9ob3N0IiwidmFsdWUiOiJodHRwczovL2dvLnNhbmRib3guc3BsaXQuY2FzaCIsImVuYWJsZWQiOnRydWV9LHsia2V5IjoiYXBpX2hvc3QiLCJ2YWx1ZSI6Imh0dHBzOi8vYXBpLnNhbmRib3guc3BsaXQuY2FzaCIsImVuYWJsZWQiOnRydWV9LHsia2V5Ijoib2F1dGgyX2FwcGxpY2F0aW9uX2lkIiwidmFsdWUiOiIiLCJlbmFibGVkIjp0cnVlfSx7ImtleSI6Im9hdXRoMl9zZWNyZXQiLCJ2YWx1ZSI6IiIsImVuYWJsZWQiOnRydWV9LHsia2V5Ijoic2NvcGUiLCJ2YWx1ZSI6InB1YmxpYyBhZ3JlZW1lbnRzIGJhbmtfYWNjb3VudHMgYmFua19jb25uZWN0aW9ucyBjb250YWN0cyBwYXltZW50cyBwYXltZW50X3JlcXVlc3RzIHJlZnVuZF9yZXF1ZXN0cyB0cmFuc2FjdGlvbnMgcmVmdW5kcyBvcGVuX2FncmVlbWVudHMgb2ZmbGluZV9hY2Nlc3MiLCJlbmFibGVkIjp0cnVlfSx7ImtleSI6Imlzbzg2MDFfbm93IiwidmFsdWUiOiIiLCJlbmFibGVkIjp0cnVlfSx7ImtleSI6ImFjY2Vzc190b2tlbiIsInZhbHVlIjoiIiwiZW5hYmxlZCI6dHJ1ZX0seyJrZXkiOiJyZWZyZXNoX3Rva2VuIiwidmFsdWUiOiIiLCJlbmFibGVkIjp0cnVlfV0=)

**A screencast of this process is also available: [https://vimeo.com/246203244](https://vimeo.com/246203244).**

1. **Create a Zepto account**

    If you haven't already, you'll want to create a sandbox Zepto account at [https://go.sandbox.split.cash](https://go.sandbox.split.cash)

2. **Register your application with Zepto**

    Sign in and create an OAuth2 application: [https://go.sandbox.split.cash/oauth/applications](https://go.sandbox.split.cash/oauth/applications).

    Use the special Postman callback URL: `https://www.getpostman.com/oauth2/callback`

    [![Zepto OAuth2 app setup](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/split_oauth2_app_setup.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/split_oauth2_app_setup.png)

3. **In Postman, setup your environment variables**

    We've included the **Zepto Public Sandbox** environment to get you started. Select it in the top right corner of the window then click the <img class="inline-1" alt="Postman Quick-Look icon" src="https://raw.githubusercontent.com/zeptofs/public_assets/master/images/postman_quick_look_icon.png" /> icon and click **edit**.

    [![Edit Postman environment](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/postman_zepto_sandbox_environment.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/postman_zepto_sandbox_environment.png)

    Using the details from the OAuth2 app you created earlier, fill in the **oauth2_application_id** & **oauth2_secret** fields.

    [![Fill in environment values](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/postman_zepto_environment_values.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/postman_zepto_environment_values.png)

4. **Setup the authorization**

    Click on the **Authorization** tab and select **OAuth 2.0**

    [![Postman Authorization tab](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/postman_authorization_tab.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/postman_authorization_tab.png)

    Click the **Get New Access Token** button

    [![Postman get new access token](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/postman_get_new_access_token.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/postman_get_new_access_token.png)

    Fill in the OAuth2 form as below:

    [![Postman OAuth2](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/postman_oauth2_form.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/postman_oauth2_form.png)

5. **Get authorised**

    Click **Request Token** and wait a few seconds and a browser window will popup

    Sign in with your Zepto account (or any other Zepto account you want to authorise).

    [![Sign in Zepto to authorise via OAuth2](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/zepto_oauth2_signin.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/zepto_oauth2_signin.png)

    Click **Authorise** to allow the app to access the signed in account. Once complete, Postman will automatically exchange the authorisation code it received from Zepto for the `access_token/refresh_token` pair. It will then store the `access_token/refresh_token` for you to use in subsequent API requests. The `access_token` effectively allows you to send requests via the API as the user who provided you authorisation.

    [![Authorise OAuth2 app](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/zepto_oauth2_authorize.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/zepto_oauth2_authorize.png)

6. **You're now ready to use the API**

    Select an endpoint from the Zepto collection from the left hand side menu. Before you send an API request ensure you select your access token and Postman will automatically add it to the request header.

    [![Postman use token](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/postman_use_token.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/postman_use_token.png)

<aside class="notice">Remember to select the access token everytime you try a new endpoint. Have fun!</aside>

## Authentication and Authorisation

Zepto uses OAuth2 over https to manage authentication and authorisation.

OAuth2 is a protocol that lets external applications request permission from another Zepto user to send requests on their behalf without getting their password.
This is preferred over Basic Authentication because access tokens can be limited by scope and can be revoked by the user at any time.

New to OAuth2? DigitalOcean has a fantastic 5 minute [introduction to OAuth2](https://www.digitalocean.com/community/tutorials/an-introduction-to-oauth-2#grant-type-authorization-code).

We currently support the **authorisation code** and **refresh token** grants.

### Authorisation Code Grant
This type of grant allows your application to act on behalf of a user. If you've ever used a website or application with your
Google, Twitter or Facebook account, this is the grant being used.

See the [Get Started guide](/#get-started) for step by step details on how to use this grant.

### Refresh Token Grant

> Code sample

```
curl -F "grant_type=refresh_token" \
     -F "client_id={{oauth2_application_id}}" \
     -F "client_secret={{oauth2_application_secret }}" \
     -F "refresh_token={{refresh_token}}" \
     -X POST https://go.sandbox.split.cash/oauth/token
```

> Example response

```json
{
    "access_token": "ad0b5847cb7d254f1e2ff1910275fe9dcb95345c9d54502d156fe35a37b93e80",
    "token_type": "bearer",
    "expires_in": 7200,
    "refresh_token": "cc38f78a5b8abe8ee81cdf25b1ca74c3fa10c3da2309de5ac37fde00cbcf2815",
    "scope": "public"
}
```

When using the authorisation code grant above, Zepto will return a `refresh token` along with the access token. Access tokens are short lived and last 2 hours but refresh tokens do not expire.

When the access token expires, instead of sending the user back through the authorisation flow you can use the refresh token to retrieve a new access token with the same permissions as the old one.

<aside class="notice">
  The <code>refresh_token</code> gets regenerated and sent alongside the new <code>access_token</code>. In other words, <code>refresh_token</code>s are single use so you'll
want to store the newly generated <code>refresh_token</code> everytime you use it to get a new <code>access_token</code>
</aside>
## Making payments
In order to payout funds, you'll be looking to use the [Payments](/#Zepto-API-Payments) endpoint. Whether you're paying out another Zepto account holder or anyone, the process is the same:

1. Add the recipient to your [Contact](/#add-a-contact) list.
2. [Make a Payment](/#make-a-payment) to your Contact.

Common use cases:

* Automated payout disbursement (Referal programs, net/commission payouts, etc...)
* Wage payments
* Gig economy payments
* Lending

## Getting paid

### POSTing a [Payment Request](/#Zepto-API-Payment-Requests)

Provides the ability to send a Payment Request (get paid) to any Contact that has an accepted Agreement in place.

To send a Payment Request to a Contact using the API, you must first have an accepted [Agreement](/#Zepto-API-Agreements) with them.

To do so, you can send them an [Open Agreement link](https://help.split.cash/agreements/open-agreement) or [Unassigned Agreement link](http://help.split.cash/agreements/unassigned-agreement) for them to [elect & verify their bank account](https://help.split.cash/bank-accounts/instant-account-verification-iav) and accept the Agreement.

Having this in place will allow any future Payment Requests to be automatically approved and processed as per the Agreement terms.

Common use cases:

* Subscriptions
* On-account balance payments
* Bill smoothing
* Repayment plans

Example flow embedding an [Open Agreement link](https://help.split.cash/agreements/open-agreement) using an iFrame in order to automate future Payment Request approvals:

[![Hosted Open Agreement](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/host_oa.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/host_oa.png)

## Idempotent requests

> Example response

```json
{
  "errors": [
    {
      "title": "Duplicate idempotency key",
      "detail": "A resource has already been created with this idempotency key",
      "links": {
        "about": "https://docs.split.cash/"
      },
      "meta": {
        "resource_ref": "PB.1a4"
      }
    }
  ]
}
```

The Zepto API supports idempotency for safely retrying requests without accidentally performing the same operation twice.
For example, if a [Payment](#Zepto-API-Payments) is `POST`ed and a there is a network connection error, you can retry the Payment with the same idempotency key to guarantee that only a single Payment is created. In case an idempotency key is not supplied and a Payment is retried, we would treat this as two different payments being made.

To perform an idempotent request, provide an additional `Idempotency-Key: <key>` header to the request.
You can pass any value as the key but we suggest that you use [V4 UUIDs](https://www.uuidtools.com/generate/v4) or another appropriately random string.

Keys expire after 24 hours. If there is a subsequent request with the same idempotency key within the 24 hour period, we will return a `409 Conflict`.

* The `meta.resource_ref` value is the reference of the resource that was previously created with the conflicting idempotency key.
* The `Idempotency-Key` header is optional but recommended.
* Only the `POST` action for the Payments, Payment Requests and Refunds endpoints support the use of the `Idempotency-Key`.
* Endpoints that use the `GET` or `DELETE` actions are idempotent by nature.
* A request that quickly follows another with the same idempotency key may return with `503 Service Unavailable`. If so, retry the request after the number of seconds specified in the `Retry-After` response header.

**Caution:** Keys are scoped to the User making the request. This means if User A makes a request with an access token they have generated to an Account using idempotency key `123` and User B makes a request with their own access token to the same Account using idempotency key `123` the requests will be treated as different and not idempotent.

Currently the following `POST` requests can be made idempotent. We **strongly recommend** sending a unique `Idempotency-Key` header when making those requests to allow for safe retries:

* [Request Payment](/#request-payment)
* [Make a Payment](/#make-a-payment)
* [Issue a Refund](/#issue-a-refund)

## Error responses

> Example detailed error response

```json
{
  "errors": [
    {
      "title": "A Specific Error",
      "detail": "Details about the error",
      "links": {
        "about": "https://docs.split.cash/..."
      }
    }
  ]
}
```
> Example resource error response

```json
{
  "errors": "A sentence explaining error/s encounted"
}
```
The Zepto API returns two different types of error responses depending on the context.

**Detailed error responses** are returned for:

* Authentication
* Request types
* Idempotency

All other errors relating to Zepto specific resources(e.g. Contacts) will return the **Resource error response** style.
<div class="middle-header">403 errors</div>

**403 errors** are generally returned from any of our endpoints if your application does not have the required authorisation. This is usually due to:

* An [invalid/expired `access_token`](/#authentication-and-authorisation); or
* The required **scopes** not being present when setting up your [OAuth application](https://go.sandbox.split.cash/oauth/applications); or
* The required **scopes** not being present in the [authorisation code link](/#oauth-grant-flow) used to present your user with an authorisation request.

## Speeding up onboarding
Consider the following scenario:

<blockquote class="main-quote">Zepto is integrated in your application to handle payments.<br>A customer would like to use Zepto but does not yet have Zepto account.<br>You already have some information about this customer.</blockquote>

Given the above, in a standard implementation where a customer enables/uses Zepto within your application, these are the steps they would follow:

1. Click on some sort of button within your app to use Zepto.
2. They get redirected to the Zepto sign in page (possibly via a popup or modal).
3. Since they don't yet have a Zepto account, they would click on sign up.
4. They would fill in all their signup details and submit.
5. They would be presented with the [authorisation page](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/oauth2_app_authorise.png).
6. They would click the "Authorise" button and be redirected to your app.

Whilst not too bad, we can do better!

In order to speed up the process, we allow query string params to be appended to the [authorisation URL](/#get-started). For instance, if we already have some information about the customer and know they probably don't have a Zepto account, we can embed this information in the authorisation URL.

**Supported query string parameters**

| Parameter | Description |
|-----------|--------|
| `landing`   | Accepted value: `sign_up`. What page the user should see first if not already signed in. Default is the sign in page. <br><br>Deprecated values: `business_sign_up`, `personal_sign_up`.|
| `nickname` | Only letters, numbers, dashes and underscores are permitted. This will be used to identify the account in Zepto. |
| `name` | Business account only. Business name. |
| `abn` | Business account only. Business ABN. |
| `phone` | Business account only. Business phone number. |
| `street_address` | |
| `suburb` | |
| `state` | See the sign up page for accepted values |
| `postcode` | |
| `first_name` | |
| `last_name` | |
| `mobile_phone` | |
| `email` | |

All values should be [URL encoded](https://en.wikipedia.org/wiki/Query_string#URL_encoding).

As an example, the following authorisation URL would display the **personal sign up** & prefill the first name field with **George**:
`https://go.sandbox.split.cash/oauth/authorize?response_type=code&client_id=xxx&redirect_uri=xxx&scope=xxx&landing=sign_up&first_name=George`

You can also pass the values directly to the sign up page outside of the OAuth2 authorisation process. Click on the following link to see the values preloaded: [https://go.sandbox.split.cash/business/sign_up?name=GeorgeCo&nickname=georgeco&first_name=George](https://go.sandbox.split.cash/business/sign_up?name=GeorgeCo&nickname=georgceco&first_name=George).

# Sandbox Testing Details

> Example failure object

```json
{
  "failure": {
      "code": "E302",
      "title": "BSB Not NPP Enabled",
      "detail": "The target BSB is not NPP enabled. Please try another channel."
  }
}
```
Try out your happy paths and not-so happy paths; the sandbox is a great place to get started without transferring actual funds. All transactions are simulated and no communication with financial institutions is performed.

The sandbox works on a 1 minute cycle to better illustrate how transactions are received and the lifecyle they go through. In other words, every minute, we simulate communicating with financial institutions and update statuses and events accordingly.

All 6 digits BSBs are valid in the sandbox with the exception of `100000`. This BSB allows you to simulate the adding of an invalid BSB. In production, only real BSBs are accepted.

Failed transactions will contain the following information inside the event:

* Failure Code
* Failure Title
* Failure Details

## DE Transaction failures
### Using failure codes
<aside class="notice">
  <ul>
      <li><a href="#de-credit-failures">DE credit failure codes</a></li>
      <li><a href="#de-debit-failures">DE debit failure codes</a></li>
  </ul>
</aside>

To simulate a transaction failure, create a Payment or Payment Request with an amount corresponding to the desired [failure code](#failure-codes).

For example:

* DE amount `$1.05` will cause the credit transaction to fail, triggering the credit failure code `E105` (Account Not Found).
* DE amount `$2.03` will cause the debit transaction to fail, triggering the debit failure code `E203` (Account Closed).

### Example scenarios

  1. Pay a contact with an invalid account number:
    * Initiate a Payment for <code>$1.05</code>.
    * Zepto will mimic a successful debit from your bank account.
    * Zepto will mimic a failure to credit the contact's bank account.
    * Zepto will automatically create a <code>payout_reversal</code> credit transaction back to your bank account.
  2. Request payment from a contact with a closed bank account:
    * Initiate a Payment Request for <code>$2.03</code>.
    * Zepto will mimic a failure to debit the contact's bank account.

## NPP Payment failures
### Using failure codes
<aside class="notice">
  <ul>
      <li><a href="#npp-credit-failures">NPP credit failure codes</a></li>
  </ul>
</aside>
To simulate a transaction failure, create a Payment with an amount corresponding to the desired [failure code](#npp-credit-failures).
For example:

* NPP amount `$3.02` will cause the transaction to fail, triggering credit failure code `E302` (BSB Not NPP Enabled).
* NPP amount `$3.04` will cause the transaction to fail, triggering credit failure code `E304` (Account Not Found).

You will receive all the same notifications as if this happened in our live environment. We recommend you check out our article on [what happens when an NPP Payment fails](https://help.split.cash/en/articles/4405560-what-happens-when-an-npp-payment-fails) to learn more about what happens when an NPP Payment is unable to process.

## Instant account verification accounts
When using any of our hosted solutions ([Payment Requests](https://help.split.cash/payment-requests/open-payment-requests), [Open Agreements](https://help.split.cash/agreements/open-agreement) or [Unassigned Agreements](http://help.split.cash/agreements/unassigned-agreement)) you may want to test the [Instant Account Verification (IAV)](http://help.split.cash/bank-accounts/instant-account-verification-iav) process where we accept online banking credentials to validate bank account access. To do so, you can use the following credentials:

| Login | Password |
|-------|----------|
| `12345678` | `TestMyMoney` |

<aside class="notice">The credentials will work with any of the available financial institutions.</aside>
## Available balances in the Sandbox
If your integration includes allowing us to pre-fail transactions prior to being processed, you may want to test that your system is handling these events correctly. A transaction will pre-fail when the available balance of the customers account is less than the amount of the payment being requested. This is checked during pre-processing just before your debit is sent for processing if there is an active bank connection.

In the Sandbox environment, if the contact you are attempting to debit has a bank connection that was created through our Instant Account Verification feature, the available balance of any **Transactional** bank account will always be `$123.45`. Any payment requests above this amount will pre-fail and any amount less than or equal to this amount will succeed.
# Configuration
## Scopes
Scopes define the level of access granted via the OAuth2 authorisation process. As a best practice, only use the scopes your application will require.

| Scope | Description |
|--------|------------|
| `public` | View user's public information |
| `agreements` | Manage user's Agreements |
| `bank_accounts` | Manage user's Bank Accounts |
| `bank_connections` | Manage user's Bank Connections |
| `contacts` | Manage user's Contacts |
| `open_agreements` | Manage user's Open Agreements |
| `payments` | Manage user's Payments |
| `payment_requests` | Manage user's Payment Requests |
| `refunds` | Manage user's Refunds |
| `transfers` | Manage user's Transfers |
| `transactions` | Access user's Transactions |
| `webhooks` | Manage user's Webhook events |
| `offline_access` | Create non-expiring access tokens for user |

  <aside class="notice">Please use `offline_access` with discretion, as you'll have no direct way to invalidate the token. Please contact Zepto immediately if any token may have potentially been compromised.</aside>

## Pagination

> Example response header

```
Link: <http://api.sandbox.split.cash/contacts?page=5>; rel="last", <http://api.sandbox.split.cash/contacts?page=2>; rel="next"
Per-Page: 25
Total: 5
```

All collections are paginated to 25 items by default and the pagination information may be found in the response header. You can customise the pagination by appending `?per_page=x` and/or `?page=x` to the endpoint URL.

<aside class="notice">The maximum <code>per_page</code> value is <code>100</code>. Any value above this will be ignored and <code>100</code> will be used instead.</aside>

## Remitter

> Example request

```json
{
  "...": "...",
  "metadata": {
   "remitter": "CustomRem"
   }
}
```

You can elect to assign a remitter name on a per-request basis when submitting Payments & Payment Requests. Simply append the `remitter` key and a value within the `metadata` key.

* **For Payments**, the party being credited will see the designated remitter name along the entry on their bank statement.
* **For Payment Requests**, the party being debited will see the designated remitter name along the entry on their bank statement.

<aside class="notice">The remitter name MUST be between <code>3</code> and <code>16</code> characters.</aside>

## Aggregation

Zepto will automatically aggregate debits that are:

- From the same bank account; and
- Have the same description; and
- Initiated by the same Zepto account.
Likewise for credits:

- To the same bank account; and
- Have the same description; and
- Initiated by the same Zepto account.

Should you prefer debit aggregation to be disabled, please contact [support@zepto.com.au](mailto:support@zepto.com.au). Note that additional charges may apply.

## Webhooks

> Example response

```json
{
  "event": {
    "type": "object.action",
    "at": "yyyy-mm-ddThh:mm:ssZ",
    "who": {
      "account_id": "x",
      "bank_account_id": "x"
    }
  },
  "data": [
    {}
  ]
}
```
Please refer to our help centre [article on webhooks](http://help.split.cash/en/articles/3303626-webhooks) for more information and an overview of what you can achieve with webhooks.

We support two main categories of webhooks:

1. **Owner**: These webhooks are managed by the owner of the Zepto account and only report on events owned by the Zepto account.
2. **App**: These webhooks are managed by the Zepto OAuth2 application owner and will report on events relating to any authorised Zepto account (limited by scope).

| Name | Type | Required | Description |
|-|-|-|-|
| event | object | true | Webhook event details |
| » type | string | true | The webhook event key (list available in the webhook settings) |
| » at | string(date-time) | true | When the event occurred |
| » who | object | true | Who the webhook event relates to |
| »» account_id | string(uuid) | true | The Zepto account who's the owner of the event |
| »» bank_account_id | string(uuid) | true | The above Zepto account's bank account |
| data | [object] | true | Array of response bodies |

### Data schemas
Use the following table to discover what type of response schema to expect for for the `data.[{}]` component of the webhook delivery.

| Event                    | Data schema                                                               |
|--------------------------|---------------------------------------------------------------------------|
| `agreement.*`            | [GetAnAgreementResponse](/#schemagetagreementresponse)                    |
| `contact.*`              | [GetAContactResponse](/#schemagetacontactresponse)                        |
| `credit.*`               | [ListAllTransactionsResponse](/#schemalistalltransactionsresponse)        |
| `creditor_debit.*`       | [ListAllTransactionsResponse](/#schemalistalltransactionsresponse)        |
| `debit.*`                | [ListAllTransactionsResponse](/#schemalistalltransactionsresponse)        |
| `debtor_credit.*`        | [ListAllTransactionsResponse](/#schemalistalltransactionsresponse)        |
| `open_agreement.*`       | [ListAllOpenAgreementsRespose](/#schemalistallopenagreementsresponse)     |
| `payment.*`              | [GetAPaymentResponse](/#schemagetapaymentresponse)                        |
| `payment_request.*`      | [GetAPaymentRequestResponse](/#schemagetapaymentrequestresponse)          |
| `unassigned_agreement.*` | [GetAnUnassignedAgreementResponse](#schemagetunassignedagreementresponse) |

### Our Delivery Promises
1. We only consider a webhook event delivery as failed if we don't receive any http response code (2xx, 4xx, 5xx, etc.)
2. We will auto-retry failed deliveries every 5 minutes for 1 hour.
3. Delivery order for webhook events is not guaranteed.
4. We guarantee at least 1 delivery attempt.

**For redelivery of webhooks, check out our [Webhook/WebhookDelivery API endpoints](#Zepto-API-Webhooks).**
<aside class="notice">
  In the sandbox environment, webhook deliveries will only be retried once,
  to allow for easier testing of failure scenarios.
</aside>

### Request ID

> Example header

```
Split-Request-ID: 07f4e8c1-846b-5ec0-8a25-24c3bc5582b5
```

Zepto provides a `Split-Request-ID` header in the form of a `UUID` which uniquely identifies a webhook event. If the webhook event is retried/retransmitted by Zepto, the UUID will remain the same. This allows you to check if a webhook event has been previously handled/processed.

### Checking Webhook Signatures

> Example header

```
Split-Signature: 1514772000.93eee90206280b25e82b38001e23961cba4c007f4d925ba71ecc2d9804978635
```

Zepto signs the webhook events it sends to your endpoints. We do so by including a signature in each event’s `Split-Signature` header. This allows you to validate that the events were indeed sent by Zepto.

Before you can verify signatures, you need to retrieve your endpoint’s secret from your Webhooks settings. Each endpoint has its own unique secret; if you use multiple endpoints, you must obtain a secret for each one.

The `Split-Signature` header contains a timestamp and one or more signatures. All separated by `.` (dot).

> Example code

```sh
# Shell example is not available
```

```go
package main
import (
    "crypto/hmac"
    "crypto/sha256"
    "strings"
    "fmt"
    "encoding/hex"
)
func main() {
    secret := "1234"
    message := "full payload of the request"
    splitSignature := "1514772000.f04cb05adb985b29d84616fbf3868e8e58403ff819cdc47ad8fc47e6acbce29f"

    data := strings.Split(splitSignature, ".")
    timestamp, givenSignature := data[0], data[1]

    signedPayload := timestamp + "." + message

    hash := hmac.New(sha256.New, []byte(secret))
    hash.Write([]byte(signedPayload))
    expectedSignature := hex.EncodeToString(hash.Sum(nil))

    fmt.Println(expectedSignature)
    // f04cb05adb985b29d84616fbf3868e8e58403ff819cdc47ad8fc47e6acbce29f
    fmt.Println(givenSignature)
    // f04cb05adb985b29d84616fbf3868e8e58403ff819cdc47ad8fc47e6acbce29f
}
```

```python
import hashlib
import hmac

split_signature = '1514772000.f04cb05adb985b29d84616fbf3868e8e58403ff819cdc47ad8fc47e6acbce29f'
secret = bytes('1234').encode('utf-8')
message = bytes('full payload of the request').encode('utf-8')

data = split_signature.split('.')
timestamp = data[0]
given_signature = data[1]

signed_payload = timestamp + '.' + message

expected_signature = hmac.new(secret, signed_payload, digestmod=hashlib.sha256).hexdigest()

print(expected_signature)
# > f04cb05adb985b29d84616fbf3868e8e58403ff819cdc47ad8fc47e6acbce29f

print(given_signature)
# > f04cb05adb985b29d84616fbf3868e8e58403ff819cdc47ad8fc47e6acbce29f
```

```ruby
require 'openssl'

split_signature = '1514772000.f04cb05adb985b29d84616fbf3868e8e58403ff819cdc47ad8fc47e6acbce29f'
secret = '1234'
message = 'full payload of the request'

timestamp, given_signature, *other = split_signature.split('.')
signed_payload = timestamp + '.' + message
expected_signature = OpenSSL::HMAC.hexdigest('sha256', secret, signed_payload)

puts(expected_signature)
# => f04cb05adb985b29d84616fbf3868e8e58403ff819cdc47ad8fc47e6acbce29f
puts(given_signature)
# => f04cb05adb985b29d84616fbf3868e8e58403ff819cdc47ad8fc47e6acbce29f
```

```javascript--node
var crypto = require('crypto')
var message = 'full payload of the request'
var secret = '1234'
var splitSignature = '1514772000.f04cb05adb985b29d84616fbf3868e8e58403ff819cdc47ad8fc47e6acbce29f'

var data = splitSignature.split('.')
var timestamp = data[0]
var givenSignature = data[1]

var signedPayload = timestamp + '.' + message

var expectedSignature = crypto.createHmac('sha256', secret).update(signedPayload).digest('hex')

console.log(expectedSignature)
// f04cb05adb985b29d84616fbf3868e8e58403ff819cdc47ad8fc47e6acbce29f
console.log(givenSignature)
// f04cb05adb985b29d84616fbf3868e8e58403ff819cdc47ad8fc47e6acbce29f

```

```php
$split_signature = '1514772000.f04cb05adb985b29d84616fbf3868e8e58403ff819cdc47ad8fc47e6acbce29f';
$secret = '1234';
$message = 'full payload of the request';

list($timestamp, $given_signature, $other) = explode('.', $split_signature);
$signed_payload = $timestamp . "." . $message;
$expected_signature = hash_hmac('sha256', $signed_payload, $secret, false);

echo $expected_signature; // f04cb05adb985b29d84616fbf3868e8e58403ff819cdc47ad8fc47e6acbce29f
echo "\n";
echo $given_signature; // f04cb05adb985b29d84616fbf3868e8e58403ff819cdc47ad8fc47e6acbce29f

```

```java
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

class Main {
  public static void main(String[] args) {
    try {
      String splitSignature = "1514772000.f04cb05adb985b29d84616fbf3868e8e58403ff819cdc47ad8fc47e6acbce29f";
      String secret = "1234";
      String message = "full payload of the request";

      String[] data = splitSignature.split("\\.");
      String timestamp = data[0];
      String givenSignature = data[1];

      String signedPayload = timestamp + "." + message;

      Mac sha256_HMAC = Mac.getInstance("HmacSHA256");
      SecretKeySpec secret_key = new SecretKeySpec(secret.getBytes(), "HmacSHA256");
      sha256_HMAC.init(secret_key);

      String expectedSignature = javax.xml.bind.DatatypeConverter.printHexBinary(sha256_HMAC.doFinal(signedPayload.getBytes())).toLowerCase();

      System.out.println(expectedSignature);
      // f04cb05adb985b29d84616fbf3868e8e58403ff819cdc47ad8fc47e6acbce29f

      System.out.println(givenSignature);
      // f04cb05adb985b29d84616fbf3868e8e58403ff819cdc47ad8fc47e6acbce29f
    }
    catch (Exception e){
      System.out.println("Error");
    }
  }
}

```
<!-- This example is commented out since the docs do not include C#
```csharp
using System; using System.Security.Cryptography;
class MainClass {
  public static void Main (string[] args) {
    var splitSignature = "1514772000.f04cb05adb985b29d84616fbf3868e8e58403ff819cdc47ad8fc47e6acbce29f";
    var secret = "1234";
    var message = "full payload of the request";

    var header = splitSignature.Split('.');
    var timeStamp = header[0];
    var givenSignature = header[1];

    var signedPayload = timeStamp + "." + message;

    var encoding = new System.Text.ASCIIEncoding();
    var hmacsha256 = new HMACSHA256(encoding.GetBytes(secret));

    byte[] hashmessage = hmacsha256.ComputeHash(encoding.GetBytes(signedPayload));
    var expectedSignature = BitConverter.ToString(hashmessage).Replace("-", "").ToLower();

    Console.WriteLine(expectedSignature);
    // f04cb05adb985b29d84616fbf3868e8e58403ff819cdc47ad8fc47e6acbce29f

    Console.WriteLine(givenSignature);
    // f04cb05adb985b29d84616fbf3868e8e58403ff819cdc47ad8fc47e6acbce29f
  }
}

```
-->

**Step 1. Extract the timestamp and signatures from the header**

Split the header, using the `.` (dot) character as the separator, to get a list of elements.

| Element | Description |
|---------|-------------|
| `timestamp` | [Unix time](https://en.wikipedia.org/wiki/Unix_time) in seconds when the signature was created |
| `signature` | Request signature |
| `other`     | Placeholder for future parameters (currently not used) |

**Step 2: Prepare the signed_payload string**

You achieve this by concatenating:

- The timestamp from the header (as a string)
- The character `.` (dot)
- The actual JSON payload (request body)

**Step 3: Determine the expected signature**

Compute an HMAC with the SHA256 hash function. Use the endpoint’s signing secret as the key, and use the `signed_payload` string as the message.

**Step 4: Compare signatures**

Compare the signature in the header to the expected signature. If a signature matches, compute the difference between the current timestamp and the received timestamp, then decide if the difference is within your tolerance.

To protect against timing attacks, use a constant-time string comparison to compare the expected signature to each of the received signatures.

<aside class="notice">The sandbox environment allow both HTTP and HTTPS webhook URLs. The live environment however will only POST to HTTPS URLs.</aside>

# Changelog
We take backwards compatibility seriously. The following list contains backwards compatible changes:

- **2022-01-21** - Reduced webhook delivery retries on sandbox to a single retry
- **2021-12-01** - Add ref to Webhook Delivery endpoint
- **2021-10-08** - Introduced improved transaction failure messaging (code, title and detail)
- **2021-09-29** - Added/expanded sandbox-only endpoints for simulating incoming payments
- **2021-09-08** - Added Webhooks and Webhook Delivery endpoints
- **2021-08-31** - Added PayID pool references to */contacts/receivable* and */bank_accounts* endpoints
- **2021-07-01** - Added $1.65 amount for Sandbox simulated failures and minor tweaks
- **2021-06-08** - Added Transfers, Payment Channel selection, Receivable Refunds
- **2021-05-21** - Added new Payment Request endpoints, updated Postman collection
- **2021-05-03** - Deprecated */payments_requests/outgoing* endpoint
- **2021-04-20** - Removed deprecated API references, refreshed Refunds and Payout descriptions
- **2021-03-17** - Remove note indicating single active bank account limitation
- **2021-03-12** - Add ref to GetAContactResponse
- **2021-02-24** - Added details on enabling the Receivable Contact feature and amended the POST/contacts/receivable response body
- **2020-12-17** - Add Sandbox Only API endpoints
- **2020-12-17** - Enhance response schema for several endpoints
- **2020-12-16** - Add webhook schema table
- **2020-12-15** - Improve webhooks section
- **2020-12-15** - Re-word Payment Requests introduction to better cover its use with Receivable Contacts.
- **2020-12-15** - Add changelog

Looking for more? Our docs are open sourced! [https://github.com/zeptofs/api-documentation](https://github.com/zeptofs/api-documentation)

<h1 id="Zepto-API-Agreements">Agreements</h1>

An Agreement is an arrangement between two parties that allows them to agree on terms for which future Payment Requests will be auto-approved.

Zepto Agreements are managed on a per Contact basis, and if a Payment Request is sent for an amount that exceeds the terms of the agreement, it will not be created.
Please refer to the [What is an Agreement](http://help.split.cash/articles/3094575-what-is-an-agreement) article in our knowledge base for an overview.
<div class="middle-header">Direction</div>

Agreements are therefore broken up by direction:

1. **Outgoing:** Agreement sent to one of your Contacts
2. **Outgoing:** Agreement sent to another Zepto account [Deprecated]
3. **Incoming:** Agreement received from another Zepto account [Deprecated]

##Lifecycle

An Agreement can have the following statuses:

| Status | Description |
|-------|-------------|
| `proposed` | Waiting for the Agreement to be accepted or declined. |
| `accepted` | The Agreement has been accepted and is active. |
| `cancelled` | The Agreement has been cancelled (The initiator or authoriser can cancel an Agreement). |
| `declined` | The Agreement has been declined. |
| `expended` | The Agreement has been expended (Only for [single_use Unassigned Agreements](/#Zepto-API-Unassigned-Agreements)). |

## List Agreements

<a id="opIdListOutgoingAgreements"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/agreements/outgoing \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/agreements/outgoing")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/agreements/outgoing",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/agreements/outgoing", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/agreements/outgoing")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/agreements/outgoing');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/agreements/outgoing"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /agreements/outgoing`

By default, all outgoing Agreements will be returned. You can apply filters to your query to customise the returned Agreements.

<h3 id="List-Agreements-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|page|query|string|false|Page of results to return, single value, exact match|
|per_page|query|string|false|Number of results per page, single value, exact match|
|authoriser_id|query|string|false|Authoriser ID (`Contact.data.account.id`), single value, exact match|
|contact_id|query|string|false|Contact ID (`Contact.data.id`), single value, exact match|
|status|query|array[string]|false|Exact match|

#### Enumerated Values

|Parameter|Value|
|---|---|
|status|proposed|
|status|accepted|
|status|declined|
|status|cancelled|

> Example responses

> 200 Response

```json
{
  "data": [
    {
      "ref": "A.4",
      "initiator_id": "4e2728cc-b4ba-42c2-a6c3-26a7758de58d",
      "authoriser_id": "8df89c16-330f-462b-8891-808d7bdceb7f",
      "contact_id": "a80ac411-c8fb-45c0-9557-607c54649907",
      "bank_account_id": "fa80ac411-c8fb-45c0-9557-607c54649907",
      "status": "proposed",
      "status_reason": null,
      "responded_at": null,
      "created_at": "2017-03-20T00:53:27Z",
      "terms": {
        "per_payout": {
          "max_amount": 10000,
          "min_amount": 1
        },
        "per_frequency": {
          "days": 7,
          "max_amount": 1000000
        }
      }
    },
    {
      "ref": "A.3",
      "initiator_id": "4e2728cc-b4ba-42c2-a6c3-26a7758de58d",
      "authoriser_id": "56df206a-aaff-471a-b075-11882bc8906a",
      "contact_id": "a80ac411-c8fb-45c0-9557-607c54649907",
      "bank_account_id": "fa80ac411-c8fb-45c0-9557-607c54649907",
      "status": "proposed",
      "status_reason": null,
      "responded_at": null,
      "created_at": "2017-03-16T22:51:48Z",
      "terms": {
        "per_payout": {
          "max_amount": 5000,
          "min_amount": 0
        },
        "per_frequency": {
          "days": "1",
          "max_amount": 10000
        }
      }
    }
  ]
}
```

<h3 id="List Agreements-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[ListOutgoingAgreementsResponse](#schemalistoutgoingagreementsresponse)|

## Get an Agreement

<a id="opIdGetAgreement"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/agreements/A.2 \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/agreements/A.2")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/agreements/A.2",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/agreements/A.2", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/agreements/A.2")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/agreements/A.2');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/agreements/A.2"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /agreements/{agreement_ref}`

Get a single Agreement by its reference

<h3 id="Get-an-Agreement-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|agreement_ref|path|string|true|Single value, exact match|

> Example responses

> 200 Response

```json
{
  "data": {
    "ref": "A.2",
    "initiator_id": "4e2728cc-b4ba-42c2-a6c3-26a7758de58d",
    "authoriser_id": "8df89c16-330f-462b-8891-808d7bdceb7f",
    "contact_id": "0d290763-bd5a-4b4d-a8ce-06c64c4a697b",
    "bank_account_id": "fb9381ec-22af-47fd-8998-804f947aaca3",
    "status": "approved",
    "status_reason": null,
    "responded_at": "2017-03-20T02:13:11Z",
    "created_at": "2017-03-20T00:53:27Z",
    "terms": {
      "per_payout": {
        "max_amount": 10000,
        "min_amount": 1
      },
      "per_frequency": {
        "days": 7,
        "max_amount": 1000000
      }
    }
  }
}
```

<h3 id="Get an Agreement-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[GetAgreementResponse](#schemagetagreementresponse)|

## Cancel an Agreement

<a id="opIdCancelAgreement"></a>

> Code samples

```shell
curl --request DELETE \
  --url https://api.sandbox.split.cash/agreements/A.2 \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/agreements/A.2")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Delete.new(url)
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "DELETE",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/agreements/A.2",
  "headers": {
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = { 'authorization': "Bearer {access-token}" }

conn.request("DELETE", "/agreements/A.2", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.delete("https://api.sandbox.split.cash/agreements/A.2")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/agreements/A.2');
$request->setRequestMethod('DELETE');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/agreements/A.2"

	req, _ := http.NewRequest("DELETE", url, nil)

	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`DELETE /agreements/{agreement_ref}`

An Agreement can be cancelled by the initiator at any time whilst the authoriser (Agreement recipient) can only cancel a previously accepted Agreement.

<h3 id="Cancel-an-Agreement-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|agreement_ref|path|string|true|Single value, exact match|

<h3 id="Cancel an Agreement-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|204|[No Content](https://tools.ietf.org/html/rfc7231#section-6.3.5)|No Content|None|

<h1 id="Zepto-API-Bank-Accounts">Bank Accounts</h1>

Your currently linked up bank accounts.

## List all Bank Accounts

<a id="opIdListAllBankAccounts"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/bank_accounts \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/bank_accounts")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/bank_accounts",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/bank_accounts", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/bank_accounts")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/bank_accounts');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/bank_accounts"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /bank_accounts`

By default, all Bank Accounts will be returned.

> Example responses

> 200 Response

```json
{
  "data": [
    {
      "id": "6a7ed958-f1e8-42dc-8c02-3901d7057357",
      "branch_code": "493192",
      "bank_name": "National Australia Bank",
      "account_number": "3993013",
      "status": "active",
      "title": "AU.493192.3993013",
      "available_balance": null
    },
    {
      "id": "56df206a-aaff-471a-b075-11882bc8906a",
      "branch_code": "302193",
      "bank_name": "National Australia Bank",
      "account_number": "119302",
      "status": "active",
      "title": "Trust Account",
      "available_balance": null
    },
    {
      "id": "ab3de19b-709b-4a41-82a5-3b43b3dc58c9",
      "branch_code": "802919",
      "bank_name": "Zepto Float Account",
      "account_number": "1748212",
      "status": "active",
      "title": "Float Account",
      "available_balance": 10000,
      "payid_configs": {
        "email_domain": "pay.zepto.com.au",
        "pooling_state": "disabled",
        "max_pool_size": 10,
        "current_pool_size": 1
      }
    }
  ]
}
```

<h3 id="List all Bank Accounts-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[ListAllBankAccountsResponse](#schemalistallbankaccountsresponse)|

<h1 id="Zepto-API-Bank-Connections">Bank Connections</h1>

Bank connections are read-only connections to your contacts' banking data. This allows Zepto (and yourself) to make intelligent transactional decisions leading to better outcomes.

Use these endpoints to:

  * List your bank connections and check their status
  * Retrieve a link that you can share with your contact to update their invalidated bank connection (e.g Their online banking credentials have changed)

<aside class="notice">To access these endpoints on behalf of another account via OAuth2, your application must request (and the user must authorise) <a href="#configuration">the bank_connections scope</a>.</aside>
<aside class="notice">Looking to add a new bank connection to a contact? See the <a href="#get-a-contact">get a contact endpoint</a></aside>

## List all Bank Connections

<a id="opIdListAllBankConnections"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/bank_connections \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/bank_connections")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/bank_connections",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/bank_connections", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/bank_connections")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/bank_connections');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/bank_connections"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /bank_connections`

By default, all Bank Connections will be returned. You can apply filters to your query to customise the returned Bank Connection list.

<h3 id="List-all-Bank-Connections-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|page|query|string|false|Page of results to return, single value, exact match|
|per_page|query|string|false|Number of results per page, single value, exact match|
|provider_name|query|string|false|Single value, exact match|
|state|query|string|false|Single value, exact match|

#### Enumerated Values

|Parameter|Value|
|---|---|
|provider_name|basiq|
|provider_name|proviso|
|provider_name|split|
|state|active|
|state|credentials_invalid|

> Example responses

> 200 Response

```json
{
  "data": [
    {
      "id": "fb497754-87e2-407d-871f-32aec39d09d4",
      "provider_name": "split",
      "state": "active",
      "refreshed_at": "2020-02-13T09:05:00Z",
      "removed_at": null,
      "failure_reason": null,
      "institution": {
        "short_name": "CBA",
        "full_name": "Commonwealth Bank of Australia"
      },
      "contact": {
        "id": "626e15b1-aa4a-496e-b5d6-3f8c1a6d2189",
        "name": "George Morissette",
        "email": "randy@windler.net"
      },
      "links": {
        "update_bank_connection": "http://go.split.cash/authorise_bank_connections/williams-and-sons-5/fb497754-87e2-407d-871f-32aec39d09d4"
      }
    },
    {
      "id": "ddbee875-7344-4d74-9503-6233149fe1a0",
      "provider_name": "split",
      "state": "credentials_invalid",
      "refreshed_at": "2020-02-13T09:05:00Z",
      "removed_at": null,
      "failure_reason": null,
      "institution": {
        "short_name": "CBA",
        "full_name": "Commonwealth Bank of Australia"
      },
      "contact": {
        "id": "72e37667-6364-440f-b1bd-56df5654e258",
        "name": "Joel Boyle",
        "email": "travis@hermanntorp.net"
      },
      "links": {
        "update_bank_connection": "http://go.split.cash/authorise_bank_connections/williams-and-sons-5/ddbee875-7344-4d74-9503-6233149fe1a0"
      }
    }
  ]
}
```

<h3 id="List all Bank Connections-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[ListAllBankConnectionsResponse](#schemalistallbankconnectionsresponse)|

## Get a Bank Connection

<a id="opIdGetABankConnection"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/bank_connections/c397645b-bd4f-4fc6-b1fe-4993fef6c3c7 \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/bank_connections/c397645b-bd4f-4fc6-b1fe-4993fef6c3c7")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/bank_connections/c397645b-bd4f-4fc6-b1fe-4993fef6c3c7",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/bank_connections/c397645b-bd4f-4fc6-b1fe-4993fef6c3c7", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/bank_connections/c397645b-bd4f-4fc6-b1fe-4993fef6c3c7")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/bank_connections/c397645b-bd4f-4fc6-b1fe-4993fef6c3c7');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/bank_connections/c397645b-bd4f-4fc6-b1fe-4993fef6c3c7"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /bank_connections/{id}`

Get a single Bank Connection by its ID

<h3 id="Get-a-Bank-Connection-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|id|path|string(UUID)|true|BankConnection ID (`BankConnection.data.id`)|

> Example responses

> 200 Response

```json
{
  "data": {
    "id": "c397645b-bd4f-4fc6-b1fe-4993fef6c3c7",
    "provider_name": "split",
    "state": "credentials_invalid",
    "refreshed_at": "2020-02-13T09:01:00Z",
    "removed_at": null,
    "failure_reason": null,
    "institution": {
      "short_name": "CBA",
      "full_name": "Commonwealth Bank of Australia"
    },
    "contact": {
      "id": "72e37667-6364-440f-b1bd-56df5654e258",
      "name": "Joel Boyle",
      "email": "travis@hermanntorp.net"
    },
    "links": {
      "update_bank_connection": "https://go.sandbox.split.cash/authorise_bank_connections/thomas-morgan-1/c397645b-bd4f-4fc6-b1fe-4993fef6c3c7"
    }
  }
}
```

<h3 id="Get a Bank Connection-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[GetABankConnectionResponse](#schemagetabankconnectionresponse)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found|None|

## Remove a Bank Connection

<a id="opIdRemoveABankConnection"></a>

> Code samples

```shell
curl --request DELETE \
  --url https://api.sandbox.split.cash/bank_connections/01586a3f-f25b-404f-b135-c42a1b7ef4de \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/bank_connections/01586a3f-f25b-404f-b135-c42a1b7ef4de")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Delete.new(url)
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "DELETE",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/bank_connections/01586a3f-f25b-404f-b135-c42a1b7ef4de",
  "headers": {
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = { 'authorization': "Bearer {access-token}" }

conn.request("DELETE", "/bank_connections/01586a3f-f25b-404f-b135-c42a1b7ef4de", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.delete("https://api.sandbox.split.cash/bank_connections/01586a3f-f25b-404f-b135-c42a1b7ef4de")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/bank_connections/01586a3f-f25b-404f-b135-c42a1b7ef4de');
$request->setRequestMethod('DELETE');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/bank_connections/01586a3f-f25b-404f-b135-c42a1b7ef4de"

	req, _ := http.NewRequest("DELETE", url, nil)

	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`DELETE /bank_connections/{id}`

<aside class="notice">Removing a Bank Connection will not affect your transaction history.</aside>

<h3 id="Remove-a-Bank-Connection-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|id|path|string(UUID)|true|BankConnection ID (`BankConnection.data.id`)|

<h3 id="Remove a Bank Connection-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|204|[No Content](https://tools.ietf.org/html/rfc7231#section-6.3.5)|No description|None|

<h1 id="Zepto-API-Contacts">Contacts</h1>

Your Contacts form an address book of parties with whom you can interact. In order to initiate any type of transaction you must first have the party in your Contact list.

<aside class="notice">In the case of Open Agreements, the authorising party will be automatically added to your Contacts list.</aside>

## Add a Contact

<a id="opIdAddAnAnyoneContact"></a>

> Code samples

```shell
curl --request POST \
  --url https://api.sandbox.split.cash/contacts/anyone \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}' \
  --header 'content-type: application/json' \
  --data '{"name":"Hunter Thompson","email":"hunter@batcountry.com","branch_code":"123456","account_number":"13048322","metadata":{"custom_key":"Custom string","another_custom_key":"Maybe a URL"}}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/contacts/anyone")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["content-type"] = 'application/json'
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'
request.body = "{\"name\":\"Hunter Thompson\",\"email\":\"hunter@batcountry.com\",\"branch_code\":\"123456\",\"account_number\":\"13048322\",\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}"

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "POST",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/contacts/anyone",
  "headers": {
    "content-type": "application/json",
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.write(JSON.stringify({
  name: 'Hunter Thompson',
  email: 'hunter@batcountry.com',
  branch_code: '123456',
  account_number: '13048322',
  metadata: { custom_key: 'Custom string', another_custom_key: 'Maybe a URL' }
}));
req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

payload = "{\"name\":\"Hunter Thompson\",\"email\":\"hunter@batcountry.com\",\"branch_code\":\"123456\",\"account_number\":\"13048322\",\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}"

headers = {
    'content-type': "application/json",
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("POST", "/contacts/anyone", payload, headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.post("https://api.sandbox.split.cash/contacts/anyone")
  .header("content-type", "application/json")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .body("{\"name\":\"Hunter Thompson\",\"email\":\"hunter@batcountry.com\",\"branch_code\":\"123456\",\"account_number\":\"13048322\",\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$body = new http\Message\Body;
$body->append('{"name":"Hunter Thompson","email":"hunter@batcountry.com","branch_code":"123456","account_number":"13048322","metadata":{"custom_key":"Custom string","another_custom_key":"Maybe a URL"}}');

$request->setRequestUrl('https://api.sandbox.split.cash/contacts/anyone');
$request->setRequestMethod('POST');
$request->setBody($body);

$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json',
  'content-type' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"strings"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/contacts/anyone"

	payload := strings.NewReader("{\"name\":\"Hunter Thompson\",\"email\":\"hunter@batcountry.com\",\"branch_code\":\"123456\",\"account_number\":\"13048322\",\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}")

	req, _ := http.NewRequest("POST", url, payload)

	req.Header.Add("content-type", "application/json")
	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`POST /contacts/anyone`

Use this endpoint when you want to pay somebody.

<aside class="notice">
  A Contact added this way cannot be debited.
</aside>

> Body parameter

```json
{
  "name": "Hunter Thompson",
  "email": "hunter@batcountry.com",
  "branch_code": "123456",
  "account_number": "13048322",
  "metadata": {
    "custom_key": "Custom string",
    "another_custom_key": "Maybe a URL"
  }
}
```

<h3 id="Add-a-Contact-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[AddAnAnyoneContactRequest](#schemaaddananyonecontactrequest)|true|No description|
|» name|body|string|true|The name of the Contact (140 max. characters)|
|» email|body|string|true|The email of the Contact (256 max. characters)|
|» branch_code|body|string|true|The bank account BSB of the Contact|
|» account_number|body|string|true|The bank account number of the Contact|
|» metadata|body|[Metadata](#schemametadata)|false|Use for your custom data and certain Zepto customisations.|

> Example responses

> 201 Response

```json
{
  "data": {
    "id": "6a7ed958-f1e8-42dc-8c02-3901d7057357",
    "name": "Hunter Thompson",
    "email": "hunter@batcountry.com",
    "type": "anyone",
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    },
    "bank_account": {
      "id": "55afddde-4296-4daf-8e49-7ba481ef9608",
      "account_number": "13048322",
      "branch_code": "123456",
      "bank_name": "National Australia Bank",
      "state": "active",
      "iav_provider": null,
      "iav_status": null,
      "blocks": {
        "debits_blocked": false,
        "credits_blocked": false
      }
    },
    "links": {
      "add_bank_connection": "https://go.sandbox.split.cash/invite_contact/thomas-morgan-1/1030bfef-cef5-4938-b10b-5841cafafc80"
    }
  }
}
```

<h3 id="Add a Contact-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|201|[Created](https://tools.ietf.org/html/rfc7231#section-6.3.2)|Created|[AddAnAnyoneContactResponse](#schemaaddananyonecontactresponse)|

## List all Contacts

<a id="opIdListAllContacts"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/contacts \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/contacts")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/contacts",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/contacts", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/contacts")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/contacts');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/contacts"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /contacts`

By default, all Contacts will be returned. You can apply filters to your query to customise the returned Contact list.

<h3 id="List-all-Contacts-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|page|query|string|false|Page of results to return, single value, exact match|
|per_page|query|string|false|Number of results per page, single value, exact match|
|name|query|string|false|Single value, string search|
|nickname|query|string|false|Single value, string search|
|email|query|string|false|Single value, string search|
|bank_account_id|query|string|false|Single value, exact match|
|bank_account_branch_code|query|string|false|Single value, exact match|
|bank_account_account_number|query|string|false|Single value, exact match|

> Example responses

> 200 Response

```json
{
  "data": [
    {
      "id": "6a7ed958-f1e8-42dc-8c02-3901d7057357",
      "name": "Outstanding Tours Pty Ltd",
      "email": "accounts@outstandingtours.com.au",
      "type": "Zepto account",
      "bank_account": {
        "id": "095c5ab7-7fa8-40fd-b317-cddbbf4c8fbc",
        "account_number": "494307",
        "branch_code": "435434",
        "bank_name": "National Australia Bank",
        "state": "active",
        "iav_provider": "split",
        "iav_status": "active",
        "blocks": {
          "debits_blocked": false,
          "credits_blocked": false
        }
      },
      "bank_connection": {
        "id": "c397645b-bd4f-4fc6-b1fe-4993fef6c3c7"
      }
    },
    {
      "id": "49935c67-c5df-4f00-99f4-1413c18a89a0",
      "name": "Adventure Dudes Pty Ltd",
      "email": "accounts@adventuredudes.com.au",
      "type": "Zepto account",
      "bank_account": {
        "id": "861ff8e4-7acf-4897-9e53-e7c5ae5f7cc0",
        "account_number": "4395959",
        "branch_code": "068231",
        "bank_name": "National Australia Bank",
        "state": "active",
        "iav_provider": "split",
        "iav_status": "credentials_invalid",
        "blocks": {
          "debits_blocked": false,
          "credits_blocked": false
        }
      },
      "bank_connection": {
        "id": "c397645b-bd4f-4fc6-b1fe-4993fef6c3c7"
      }
    },
    {
      "id": "eb3266f9-e172-4b6c-b802-fe5ac4d3250a",
      "name": "Surfing World Pty Ltd",
      "email": "accounts@surfingworld.com.au",
      "type": "Zepto account",
      "bank_account": {
        "id": null,
        "account_number": null,
        "branch_code": null,
        "bank_name": null,
        "state": "disabled",
        "iav_provider": null,
        "iav_status": null,
        "blocks": {
          "debits_blocked": false,
          "credits_blocked": false
        }
      },
      "links": {
        "add_bank_connection": "https://go.sandbox.split.cash/invite_contact/thomas-morgan-1/1030bfef-cef5-4938-b10b-5841cafafc80"
      }
    },
    {
      "id": "6a7ed958-f1e8-42dc-8c02-3901d7057357",
      "name": "Hunter Thompson",
      "email": "hunter@batcountry.com",
      "type": "anyone",
      "bank_account": {
        "id": "55afddde-4296-4daf-8e49-7ba481ef9608",
        "account_number": "13048322",
        "branch_code": "123456",
        "bank_name": "National Australia Bank",
        "state": "pending_verification",
        "iav_provider": null,
        "iav_status": null,
        "blocks": {
          "debits_blocked": false,
          "credits_blocked": false
        }
      },
      "links": {
        "add_bank_connection": "https://go.sandbox.split.cash/invite_contact/thomas-morgan-1/1030bfef-cef5-4938-b10b-5841cafafc80"
      }
    }
  ]
}
```

<h3 id="List all Contacts-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[ListAllContactsResponse](#schemalistallcontactsresponse)|

## Get a Contact

<a id="opIdGetAContact"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/contacts/55afddde-4296-4daf-8e49-7ba481ef9608 \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/contacts/55afddde-4296-4daf-8e49-7ba481ef9608")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/contacts/55afddde-4296-4daf-8e49-7ba481ef9608",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/contacts/55afddde-4296-4daf-8e49-7ba481ef9608", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/contacts/55afddde-4296-4daf-8e49-7ba481ef9608")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/contacts/55afddde-4296-4daf-8e49-7ba481ef9608');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/contacts/55afddde-4296-4daf-8e49-7ba481ef9608"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /contacts/{id}`

Get a single Contact by its ID

<h3 id="Get-a-Contact-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|id|path|string(UUID)|true|Contact ID (`Contact.data.id`)|

> Example responses

> 200 Response

```json
{
  "data": {
    "id": "55afddde-4296-4daf-8e49-7ba481ef9608",
    "ref": "CNT.123",
    "name": "Outstanding Tours Pty Ltd",
    "email": "accounts@outstandingtours.com.au",
    "type": "anyone",
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    },
    "bank_account": {
      "id": "fcabeacb-2ef6-4b27-ba19-4f6fa0d57dcb",
      "account_number": "947434694",
      "branch_code": "304304",
      "bank_name": "National Australia Bank",
      "state": "active",
      "iav_provider": null,
      "iav_status": null,
      "blocks": {
        "debits_blocked": false,
        "credits_blocked": false
      }
    },
    "anyone_account": {
      "id": "31a05f81-25a2-4085-92ef-0d16d0263bff"
    },
    "bank_connection": {
      "id": null
    },
    "links": {
      "add_bank_connection": "https://go.sandbox.split.cash/invite_contact/thomas-morgan-1/1030bfef-cef5-4938-b10b-5841cafafc80"
    },
    "payid_details": {
      "alias_value": "otp@pay.travel.com.au",
      "alias_type": "email",
      "alias_name": "your merchant's alias_name",
      "state": "active"
    }
  }
}
```

<h3 id="Get a Contact-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[GetAContactResponse](#schemagetacontactresponse)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found|None|

## Remove a Contact

<a id="opIdRemoveAContact"></a>

> Code samples

```shell
curl --request DELETE \
  --url https://api.sandbox.split.cash/contacts/55afddde-4296-4daf-8e49-7ba481ef9608 \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/contacts/55afddde-4296-4daf-8e49-7ba481ef9608")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Delete.new(url)
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "DELETE",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/contacts/55afddde-4296-4daf-8e49-7ba481ef9608",
  "headers": {
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = { 'authorization': "Bearer {access-token}" }

conn.request("DELETE", "/contacts/55afddde-4296-4daf-8e49-7ba481ef9608", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.delete("https://api.sandbox.split.cash/contacts/55afddde-4296-4daf-8e49-7ba481ef9608")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/contacts/55afddde-4296-4daf-8e49-7ba481ef9608');
$request->setRequestMethod('DELETE');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/contacts/55afddde-4296-4daf-8e49-7ba481ef9608"

	req, _ := http.NewRequest("DELETE", url, nil)

	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`DELETE /contacts/{id}`

<aside class="notice">
  <ul>
    <li>Removing a Contact will not affect your transaction history.</li>
    <li>Removing a Receivable Contact will deactivate any associated PayIDs.</li>
  </ul>
</aside>

<h3 id="Remove-a-Contact-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|id|path|string(UUID)|true|Contact ID (`Contact.data.id`)|

<h3 id="Remove a Contact-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|204|[No Content](https://tools.ietf.org/html/rfc7231#section-6.3.5)|No description|None|

## Update a Contact

<a id="opIdUpdateAContact"></a>

> Code samples

```shell
curl --request PATCH \
  --url https://api.sandbox.split.cash/contacts/55afddde-4296-4daf-8e49-7ba481ef9608 \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}' \
  --header 'content-type: application/json' \
  --data '{"name":"My very own alias","email":"updated@email.com","branch_code":"123456","account_number":"99887766","metadata":{"custom_key":"Custom string","another_custom_key":"Maybe a URL"}}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/contacts/55afddde-4296-4daf-8e49-7ba481ef9608")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Patch.new(url)
request["content-type"] = 'application/json'
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'
request.body = "{\"name\":\"My very own alias\",\"email\":\"updated@email.com\",\"branch_code\":\"123456\",\"account_number\":\"99887766\",\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}"

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "PATCH",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/contacts/55afddde-4296-4daf-8e49-7ba481ef9608",
  "headers": {
    "content-type": "application/json",
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.write(JSON.stringify({
  name: 'My very own alias',
  email: 'updated@email.com',
  branch_code: '123456',
  account_number: '99887766',
  metadata: { custom_key: 'Custom string', another_custom_key: 'Maybe a URL' }
}));
req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

payload = "{\"name\":\"My very own alias\",\"email\":\"updated@email.com\",\"branch_code\":\"123456\",\"account_number\":\"99887766\",\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}"

headers = {
    'content-type': "application/json",
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("PATCH", "/contacts/55afddde-4296-4daf-8e49-7ba481ef9608", payload, headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.patch("https://api.sandbox.split.cash/contacts/55afddde-4296-4daf-8e49-7ba481ef9608")
  .header("content-type", "application/json")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .body("{\"name\":\"My very own alias\",\"email\":\"updated@email.com\",\"branch_code\":\"123456\",\"account_number\":\"99887766\",\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$body = new http\Message\Body;
$body->append('{"name":"My very own alias","email":"updated@email.com","branch_code":"123456","account_number":"99887766","metadata":{"custom_key":"Custom string","another_custom_key":"Maybe a URL"}}');

$request->setRequestUrl('https://api.sandbox.split.cash/contacts/55afddde-4296-4daf-8e49-7ba481ef9608');
$request->setRequestMethod('PATCH');
$request->setBody($body);

$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json',
  'content-type' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"strings"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/contacts/55afddde-4296-4daf-8e49-7ba481ef9608"

	payload := strings.NewReader("{\"name\":\"My very own alias\",\"email\":\"updated@email.com\",\"branch_code\":\"123456\",\"account_number\":\"99887766\",\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}")

	req, _ := http.NewRequest("PATCH", url, payload)

	req.Header.Add("content-type", "application/json")
	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`PATCH /contacts/{id}`

You can update the name, email, bank account and metadata of any Contact.
<aside class="notice">
  <ul>
    <li>Previous transactions to this Contact will retain the name and bank account that was used at the time.</li>
    <li>You cannot update a Contact's bank account details if they currently have an accepted agreement.</li>
    <li>Any active Bank Connections will be lost if you change the Contact's bank account.</li>
    <li>See our [Help Article](https://help.split.cash/en/articles/3829211-how-do-i-change-my-customers-bank-account-details) for more information about the nuances and implications of changing a contacts Bank Account.</li>
  </ul>
</aside>

> Body parameter

```json
{
  "name": "My very own alias",
  "email": "updated@email.com",
  "branch_code": "123456",
  "account_number": "99887766",
  "metadata": {
    "custom_key": "Custom string",
    "another_custom_key": "Maybe a URL"
  }
}
```

<h3 id="Update-a-Contact-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|id|path|string|true|Contact ID (`Contact.data.id`)|
|body|body|[UpdateAContactRequest](#schemaupdateacontactrequest)|true|No description|
|» name|body|string|false|The name of the Contact|
|» email|body|string|false|The email of the Contact|
|» branch_code|body|string|false|The bank account BSB of the Contact|
|» account_number|body|string|false|The bank account number of the Contact|
|» metadata|body|[Metadata](#schemametadata)|false|Use for your custom data and certain Zepto customisations.|

> Example responses

> 200 Response

```json
{
  "data": {
    "id": "fcabeacb-2ef6-4b27-ba19-4f6fa0d57dcb",
    "name": "My very own alias",
    "email": "updated@email.com",
    "type": "anyone",
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    },
    "bank_account": {
      "id": "55afddde-4296-4daf-8e49-7ba481ef9608",
      "account_number": "99887766",
      "branch_code": "123456",
      "bank_name": "Zepto SANDBOX Bank",
      "state": "active",
      "iav_provider": null,
      "iav_status": null,
      "blocks": {
        "debits_blocked": false,
        "credits_blocked": false
      }
    },
    "anyone_account": {
      "id": "63232c0a-a783-4ae9-ae73-f0974fe1e345"
    },
    "links": {
      "add_bank_connection": "http://go.sandbox.split.cash/invite_contact/dog-bones-inc/fcabeacb-2ef6-4b27-ba19-4f6fa0d57dcb"
    }
  }
}
```

<h3 id="Update a Contact-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[UpdateAContactResponse](#schemaupdateacontactresponse)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found|None|

<h1 id="Zepto-API-Contacts--Receivable-">Contacts (Receivable)</h1>

## Add a Receivable Contact

<a id="opIdAddAReceivableContact"></a>

> Code samples

```shell
curl --request POST \
  --url https://api.sandbox.split.cash/contacts/receivable \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}' \
  --header 'content-type: application/json' \
  --data '{"name":"Delphine Jestin","email":"delphine@gmail.com","payid_email":"delphine_123@merchant.com.au","metadata":{"custom_key":"Custom string","another_custom_key":"Maybe a URL"}}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/contacts/receivable")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["content-type"] = 'application/json'
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'
request.body = "{\"name\":\"Delphine Jestin\",\"email\":\"delphine@gmail.com\",\"payid_email\":\"delphine_123@merchant.com.au\",\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}"

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "POST",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/contacts/receivable",
  "headers": {
    "content-type": "application/json",
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.write(JSON.stringify({
  name: 'Delphine Jestin',
  email: 'delphine@gmail.com',
  payid_email: 'delphine_123@merchant.com.au',
  metadata: { custom_key: 'Custom string', another_custom_key: 'Maybe a URL' }
}));
req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

payload = "{\"name\":\"Delphine Jestin\",\"email\":\"delphine@gmail.com\",\"payid_email\":\"delphine_123@merchant.com.au\",\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}"

headers = {
    'content-type': "application/json",
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("POST", "/contacts/receivable", payload, headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.post("https://api.sandbox.split.cash/contacts/receivable")
  .header("content-type", "application/json")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .body("{\"name\":\"Delphine Jestin\",\"email\":\"delphine@gmail.com\",\"payid_email\":\"delphine_123@merchant.com.au\",\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$body = new http\Message\Body;
$body->append('{"name":"Delphine Jestin","email":"delphine@gmail.com","payid_email":"delphine_123@merchant.com.au","metadata":{"custom_key":"Custom string","another_custom_key":"Maybe a URL"}}');

$request->setRequestUrl('https://api.sandbox.split.cash/contacts/receivable');
$request->setRequestMethod('POST');
$request->setBody($body);

$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json',
  'content-type' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"strings"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/contacts/receivable"

	payload := strings.NewReader("{\"name\":\"Delphine Jestin\",\"email\":\"delphine@gmail.com\",\"payid_email\":\"delphine_123@merchant.com.au\",\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}")

	req, _ := http.NewRequest("POST", url, payload)

	req.Header.Add("content-type", "application/json")
	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`POST /contacts/receivable`

Receive funds from a Contact by allowing them to pay to a personalised PayID or account number. Perfect for reconciling incoming funds to a customer, receiving funds instantly, eliminating human error & improving your customer's experience.

<aside class="notice">
  To enable this feature, please contact our support team with the following information:
    <li>Your full legal business name</li>
    <li>A legally owned domain name: for your PayID email addresses</li>
    <li><strong>alias_name</strong>: the business name that will be displayed to your customers upon PayID resolution. We suggest using a shortened name appropriate for mobile displays</li>
</aside>
<aside class="notice">
  There are two strategies supported for PayID assignment when creating this type of Contact:
  <li><strong>On-demand PayID</strong>: provide a <code>payid_email</code> and we'll create a contact and register a PayID with the given email address. The PayID registration process happens when the request is received. The initial response for <code>payid_details.state</code> will always be <code>pending</code>. It will transition to <code>active</code> when the PayID registration process is complete. This can take up to a few seconds. You can use webhooks to be informed of this state change.</li>
  <li><strong>Pooled PayID</strong>: provide your <code>payid_email_domain</code> and we'll create a contact and assign them a PayID from your pool. Pooled PayIDs are pre-registered. The PayID email value is generated using a random value and the email domain from your PayID pool configuration. Providing both <code>payid_email</code> and <code>payid_email_domain</code> will ignore your pool and use the "On-demand PayID" strategy instead.</li>
</aside>
<aside class="notice">
  While unlikely, it is possible that we will be unable to register the given PayID. In this case <code>payid_details.state</code> will transition to <code>failed</code>.

  You can simulate this path in sandbox by adding <code>+failure</code> to your <code>payid_email</code> e.g <code>test+failure@split.cash</code>
</aside>
<aside class="notice">
  You can test receiving payments to a Receivable Contact in our sandbox environment using the <a href="#simulate-incoming-payid-payment">PayID simulation endpoint</a>.
</aside>

> Body parameter

```json
{
  "name": "Delphine Jestin",
  "email": "delphine@gmail.com",
  "payid_email": "delphine_123@merchant.com.au",
  "metadata": {
    "custom_key": "Custom string",
    "another_custom_key": "Maybe a URL"
  }
}
```

<h3 id="Add-a-Receivable-Contact-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[AddAReceivableContactRequest](#schemaaddareceivablecontactrequest)|true|No description|
|» name|body|string|true|Contact name (Min: 3 - Max: 140)|
|» email|body|string|true|Contact email (Min: 6 - Max: 256)|
|» payid_email|body|string|false|Contact PayID email (Min: 6 - Max: 256)|
|» payid_email_domain|body|string|false|PayID pool email domain (Min: 3 - Max: 254)|
|» metadata|body|[Metadata](#schemametadata)|false|Use for your custom data and certain Zepto customisations.|

> Example responses

> 201 Response

```json
{
  "data": {
    "id": "6a7ed958-f1e8-42dc-8c02-3901d7057357",
    "name": "Delphine Jestin",
    "email": "delphine@gmail.com",
    "type": "anyone",
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    },
    "bank_account": {
      "id": "55afddde-4296-4daf-8e49-7ba481ef9608",
      "account_number": "1408281",
      "branch_code": "802919",
      "bank_name": "Zepto Float Account",
      "state": "active",
      "iav_provider": null,
      "iav_status": null,
      "blocks": {
        "debits_blocked": false,
        "credits_blocked": false
      }
    },
    "anyone_account": {
      "id": "77be6ecc-5fa7-454b-86d6-02a5f147878d"
    },
    "payid_details": {
      "alias_value": "delphine_123@merchant.com.au",
      "alias_type": "email",
      "alias_name": "your merchant's alias_name",
      "state": "pending"
    }
  }
}
```

<h3 id="Add a Receivable Contact-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|201|[Created](https://tools.ietf.org/html/rfc7231#section-6.3.2)|Created|[AddAReceivableContactResponse](#schemaaddareceivablecontactresponse)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found|None|

## Disable a Receivable Contact

<a id="opIdDisableAReceivableContact"></a>

> Code samples

```shell
curl --request POST \
  --url https://api.sandbox.split.cash/contacts/2d2429c2-b868-455e-80ef-915df7c115a7/receivable/disable \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/contacts/2d2429c2-b868-455e-80ef-915df7c115a7/receivable/disable")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "POST",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/contacts/2d2429c2-b868-455e-80ef-915df7c115a7/receivable/disable",
  "headers": {
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = { 'authorization': "Bearer {access-token}" }

conn.request("POST", "/contacts/2d2429c2-b868-455e-80ef-915df7c115a7/receivable/disable", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.post("https://api.sandbox.split.cash/contacts/2d2429c2-b868-455e-80ef-915df7c115a7/receivable/disable")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/contacts/2d2429c2-b868-455e-80ef-915df7c115a7/receivable/disable');
$request->setRequestMethod('POST');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/contacts/2d2429c2-b868-455e-80ef-915df7c115a7/receivable/disable"

	req, _ := http.NewRequest("POST", url, nil)

	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`POST /contacts/{contact_id}/receivable/disable`

This endpoint should be used to Disable a Receivable Contact.

This will reject all payments made to the relevant Account number or PayID and return them to your customer. Payments made via DE and NPP will be rejected.

<h3 id="Disable-a-Receivable-Contact-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|contact_id|path|string(UUID)|true|Receivable Contact ID (`ReceivableContact.data.id`)|

<h3 id="Disable a Receivable Contact-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|204|[No Content](https://tools.ietf.org/html/rfc7231#section-6.3.5)|No Content (success)|None|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request (errors)|None|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found|None|

## Reactivate a Receivable Contact

<a id="opIdActivateAReceivableContact"></a>

> Code samples

```shell
curl --request POST \
  --url https://api.sandbox.split.cash/contacts/2d2429c2-b868-455e-80ef-915df7c115a7/receivable/activate \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/contacts/2d2429c2-b868-455e-80ef-915df7c115a7/receivable/activate")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "POST",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/contacts/2d2429c2-b868-455e-80ef-915df7c115a7/receivable/activate",
  "headers": {
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = { 'authorization': "Bearer {access-token}" }

conn.request("POST", "/contacts/2d2429c2-b868-455e-80ef-915df7c115a7/receivable/activate", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.post("https://api.sandbox.split.cash/contacts/2d2429c2-b868-455e-80ef-915df7c115a7/receivable/activate")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/contacts/2d2429c2-b868-455e-80ef-915df7c115a7/receivable/activate');
$request->setRequestMethod('POST');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/contacts/2d2429c2-b868-455e-80ef-915df7c115a7/receivable/activate"

	req, _ := http.NewRequest("POST", url, nil)

	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`POST /contacts/{contact_id}/receivable/activate`

This endpoint should be used to Reactivate a Receivable Contact that has been previously Disabled.

This will once again allow you to receive funds from your customer via both DE and NPP channels.

<h3 id="Reactivate-a-Receivable-Contact-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|contact_id|path|string(UUID)|true|Receivable Contact ID (`ReceivableContact.data.id`)|

<h3 id="Reactivate a Receivable Contact-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|204|[No Content](https://tools.ietf.org/html/rfc7231#section-6.3.5)|No Content (success)|None|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request (errors)|None|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found|None|

## Update a Receivable Contact

<a id="opIdUpdateAReceivableContact"></a>

> Code samples

```shell
curl --request PATCH \
  --url https://api.sandbox.split.cash/contacts/2d2429c2-b868-455e-80ef-915df7c115a7/receivable/ \
  --header 'authorization: Bearer {access-token}' \
  --header 'content-type: application/json' \
  --data '{"payid_name":"Bob Smith"}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/contacts/2d2429c2-b868-455e-80ef-915df7c115a7/receivable/")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Patch.new(url)
request["content-type"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'
request.body = "{\"payid_name\":\"Bob Smith\"}"

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "PATCH",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/contacts/2d2429c2-b868-455e-80ef-915df7c115a7/receivable/",
  "headers": {
    "content-type": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.write(JSON.stringify({ payid_name: 'Bob Smith' }));
req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

payload = "{\"payid_name\":\"Bob Smith\"}"

headers = {
    'content-type': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("PATCH", "/contacts/2d2429c2-b868-455e-80ef-915df7c115a7/receivable/", payload, headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.patch("https://api.sandbox.split.cash/contacts/2d2429c2-b868-455e-80ef-915df7c115a7/receivable/")
  .header("content-type", "application/json")
  .header("authorization", "Bearer {access-token}")
  .body("{\"payid_name\":\"Bob Smith\"}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$body = new http\Message\Body;
$body->append('{"payid_name":"Bob Smith"}');

$request->setRequestUrl('https://api.sandbox.split.cash/contacts/2d2429c2-b868-455e-80ef-915df7c115a7/receivable/');
$request->setRequestMethod('PATCH');
$request->setBody($body);

$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'content-type' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"strings"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/contacts/2d2429c2-b868-455e-80ef-915df7c115a7/receivable/"

	payload := strings.NewReader("{\"payid_name\":\"Bob Smith\"}")

	req, _ := http.NewRequest("PATCH", url, payload)

	req.Header.Add("content-type", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`PATCH /contacts/{contact_id}/receivable/`

You can update the PayID name of a Receivable Contact.

<aside class="notice">
  The Receivable Contact you are updating must be active.
</aside>

> Body parameter

```json
{
  "payid_name": "Bob Smith"
}
```

<h3 id="Update-a-Receivable-Contact-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|contact_id|path|string(UUID)|true|Receivable Contact ID (`ReceivableContact.data.id`)|
|body|body|[UpdateAReceivableContactRequest](#schemaupdateareceivablecontactrequest)|true|No description|
|» payid_name|body|string|true|The PayID name of the Receivable Contact|

<h3 id="Update a Receivable Contact-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|202|[Accepted](https://tools.ietf.org/html/rfc7231#section-6.3.3)|Accepted|None|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request (errors)|None|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found|None|

<h1 id="Zepto-API-Open-Agreements">Open Agreements</h1>

An Open Agreement is essentially an Agreement template with no specific authoriser. Each time an Open Agreement is accepted by either a Zepto account holder or anyone, the authoriser is added to your Contacts list and a new Agreement is automatically created between the Open Agreement initiator and the authoriser.

An Open Agreement can be accepted multiple times by different parties and the result is the same: A new Agreement. Additionally, an Open Agreement can be accepted by anybody, not just other Zepto users. This is achieved by using our [Instant Account Verification process](http://help.split.cash/bank-accounts/instant-account-verification-iav) as part of accepting an [Open Agreement](https://help.split.cash/agreements/open-agreement).
##Lifecycle

An Open Agreement can have the following statuses:

| Status | Description |
|-------|-------------|
| `active` | The Open Agreement can be viewed and accepted. |
| `closed` | The Open Agreement can not be viewed or accepted. |

<aside class="notice">When you close an Open Agreement, no new Agreements can be created from it and all past Agreement resulting from the acceptance of the Open Agreement are unaffected.</aside>

## Create an Open Agreement

<a id="opIdCreateOpenAgreement"></a>

> Code samples

```shell
curl --request POST \
  --url https://api.sandbox.split.cash/open_agreements \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}' \
  --header 'content-type: application/json' \
  --data '{"title":"Subscription Plan A","terms":{"per_payout":{"min_amount":null,"max_amount":10000},"per_frequency":{"days":7,"max_amount":1000000}},"metadata":{"custom_key":"Custom string","another_custom_key":"Maybe a URL"}}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/open_agreements")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["content-type"] = 'application/json'
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'
request.body = "{\"title\":\"Subscription Plan A\",\"terms\":{\"per_payout\":{\"min_amount\":null,\"max_amount\":10000},\"per_frequency\":{\"days\":7,\"max_amount\":1000000}},\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}"

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "POST",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/open_agreements",
  "headers": {
    "content-type": "application/json",
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.write(JSON.stringify({
  title: 'Subscription Plan A',
  terms: {
    per_payout: { min_amount: null, max_amount: 10000 },
    per_frequency: { days: 7, max_amount: 1000000 }
  },
  metadata: { custom_key: 'Custom string', another_custom_key: 'Maybe a URL' }
}));
req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

payload = "{\"title\":\"Subscription Plan A\",\"terms\":{\"per_payout\":{\"min_amount\":null,\"max_amount\":10000},\"per_frequency\":{\"days\":7,\"max_amount\":1000000}},\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}"

headers = {
    'content-type': "application/json",
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("POST", "/open_agreements", payload, headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.post("https://api.sandbox.split.cash/open_agreements")
  .header("content-type", "application/json")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .body("{\"title\":\"Subscription Plan A\",\"terms\":{\"per_payout\":{\"min_amount\":null,\"max_amount\":10000},\"per_frequency\":{\"days\":7,\"max_amount\":1000000}},\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$body = new http\Message\Body;
$body->append('{"title":"Subscription Plan A","terms":{"per_payout":{"min_amount":null,"max_amount":10000},"per_frequency":{"days":7,"max_amount":1000000}},"metadata":{"custom_key":"Custom string","another_custom_key":"Maybe a URL"}}');

$request->setRequestUrl('https://api.sandbox.split.cash/open_agreements');
$request->setRequestMethod('POST');
$request->setBody($body);

$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json',
  'content-type' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"strings"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/open_agreements"

	payload := strings.NewReader("{\"title\":\"Subscription Plan A\",\"terms\":{\"per_payout\":{\"min_amount\":null,\"max_amount\":10000},\"per_frequency\":{\"days\":7,\"max_amount\":1000000}},\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}")

	req, _ := http.NewRequest("POST", url, payload)

	req.Header.Add("content-type", "application/json")
	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`POST /open_agreements`

Create an Open Agreement that can be accepted by anyone.

<aside class="notice">You can set any of the term metrics to <code>null</code> if you wish them to not have a limit.</aside>

> Body parameter

```json
{
  "title": "Subscription Plan A",
  "terms": {
    "per_payout": {
      "min_amount": null,
      "max_amount": 10000
    },
    "per_frequency": {
      "days": 7,
      "max_amount": 1000000
    }
  },
  "metadata": {
    "custom_key": "Custom string",
    "another_custom_key": "Maybe a URL"
  }
}
```

<h3 id="Create-an-Open-Agreement-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[CreateOpenAgreementRequest](#schemacreateopenagreementrequest)|true|No description|
|» title|body|string|true|Title of the Open Agreement (Visible to authorisers)|
|» terms|body|[Terms](#schematerms)|true|Terms|
|»» per_payout|body|[PerPayout](#schemaperpayout)|true|No description|
|»»» min_amount|body|integer|true|Minimum amount in cents a Payment Request can be in order to be auto-approved. Specify <code>null</code> for no limit.|
|»»» max_amount|body|integer|true|Maximum amount in cents a Payment Request can be in order to be auto-approved. Specify <code>null</code> for no limit.|
|»» per_frequency|body|[PerFrequency](#schemaperfrequency)|true|No description|
|»»» days|body|integer|true|Amount of days to apply against the frequency. Specify <code>null</code> for no limit.|
|»»» max_amount|body|integer|true|Maximum amount in cents the total of all PRs can be for the duration of the frequency. Specify <code>null</code> for no limit.|
|»» metadata|body|[Metadata](#schemametadata)|false|Use for your custom data and certain Zepto customisations.|

> Example responses

> 200 Response

```json
{
  "data": {
    "ref": "OA.1",
    "title": "Subscription Plan A",
    "status": "active",
    "created_at": "2017-03-20T00:53:27Z",
    "terms": {
      "per_payout": {
        "min_amount": null,
        "max_amount": 10000
      },
      "per_frequency": {
        "days": 7,
        "max_amount": 1000000
      }
    },
    "link": "https://go.sandbox.split.cash/open_agreements/aecff76d-13e0-4e17-b7c5-844ae07fa675/agreements/invitation"
  }
}
```

<h3 id="Create an Open Agreement-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Created|[CreateOpenAgreementResponse](#schemacreateopenagreementresponse)|

## List all Open Agreements

<a id="opIdListAllOpenAgreements"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/open_agreements \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/open_agreements")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/open_agreements",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/open_agreements", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/open_agreements")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/open_agreements');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/open_agreements"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /open_agreements`

By default, all Open Agreements will be returned.

<h3 id="List-all-Open-Agreements-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|page|query|string|false|Page of results to return, single value, exact match|
|per_page|query|string|false|Number of results per page, single value, exact match|

> Example responses

> 200 Response

```json
{
  "data": [
    {
      "ref": "OA.1",
      "title": "Subscription Plan A",
      "status": "active",
      "created_at": "2017-03-20T00:53:27Z",
      "terms": {
        "per_payout": {
          "max_amount": 10000,
          "min_amount": null
        },
        "per_frequency": {
          "days": 7,
          "max_amount": 1000000
        }
      },
      "link": "https://go.sandbox.split.cash/open_agreements/2e002c0b-ffaf-44eb-a35c-15fa384ddde1/agreements/invitation"
    },
    {
      "ref": "OA.2",
      "title": "Subscription Plan B",
      "status": "closed",
      "created_at": "2017-03-20T00:53:27Z",
      "terms": {
        "per_payout": {
          "max_amount": 10000,
          "min_amount": null
        },
        "per_frequency": {
          "days": null,
          "max_amount": null
        }
      },
      "link": "https://go.sandbox.split.cash/open_agreements/948e3662-154d-42d1-bdc9-a05c251d3981/agreements/invitation"
    }
  ]
}
```

<h3 id="List all Open Agreements-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[ListAllOpenAgreementsResponse](#schemalistallopenagreementsresponse)|

## Activate a closed Open Agreement

<a id="opIdActivateOpenAgreement"></a>

> Code samples

```shell
curl --request POST \
  --url https://api.sandbox.split.cash/open_agreements/OA.1/activate \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/open_agreements/OA.1/activate")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "POST",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/open_agreements/OA.1/activate",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("POST", "/open_agreements/OA.1/activate", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.post("https://api.sandbox.split.cash/open_agreements/OA.1/activate")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/open_agreements/OA.1/activate');
$request->setRequestMethod('POST');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/open_agreements/OA.1/activate"

	req, _ := http.NewRequest("POST", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`POST /open_agreements/{open_agreement_ref}/activate`

Allow the Open Agreement to viewed and accepted.

<h3 id="Activate-a-closed-Open-Agreement-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|open_agreement_ref|path|string|true|Single value, exact match|

> Example responses

> 200 Response

```json
{
  "data": {
    "ref": "OA.1",
    "title": "Subscription Plan A",
    "status": "active",
    "created_at": "2017-03-20T00:53:27Z",
    "terms": {
      "per_payout": {
        "max_amount": 10000,
        "min_amount": null
      },
      "per_frequency": {
        "days": 7,
        "max_amount": 1000000
      }
    },
    "link": "https://go.sandbox.split.cash/open_agreements/2e002c0b-ffaf-44eb-a35c-15fa384ddde1/agreements/invitation"
  }
}
```

<h3 id="Activate a closed Open Agreement-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[ActivateOpenAgreementResponse](#schemaactivateopenagreementresponse)|

## Close an active Open Agreement

<a id="opIdCloseOpenAgreement"></a>

> Code samples

```shell
curl --request POST \
  --url https://api.sandbox.split.cash/open_agreements/OA.1/close \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/open_agreements/OA.1/close")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "POST",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/open_agreements/OA.1/close",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("POST", "/open_agreements/OA.1/close", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.post("https://api.sandbox.split.cash/open_agreements/OA.1/close")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/open_agreements/OA.1/close');
$request->setRequestMethod('POST');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/open_agreements/OA.1/close"

	req, _ := http.NewRequest("POST", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`POST /open_agreements/{open_agreement_ref}/close`

Disable the Open Agreement from being viewed or accepted.

<h3 id="Close-an-active-Open-Agreement-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|open_agreement_ref|path|string|true|Single value, exact match|

> Example responses

> 200 Response

```json
{
  "data": {
    "ref": "OA.1",
    "title": "Subscription Plan A",
    "status": "closed",
    "created_at": "2017-03-20T00:53:27Z",
    "terms": {
      "per_payout": {
        "max_amount": 10000,
        "min_amount": null
      },
      "per_frequency": {
        "days": 7,
        "max_amount": 1000000
      }
    },
    "link": "https://go.sandbox.split.cash/open_agreements/2e002c0b-ffaf-44eb-a35c-15fa384ddde1/agreements/invitation"
  }
}
```

<h3 id="Close an active Open Agreement-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[CloseOpenAgreementResponse](#schemacloseopenagreementresponse)|

<h1 id="Zepto-API-Payment-Requests">Payment Requests</h1>

A Payment Request (PR) is used to collect funds, via direct debit, from one of your Contacts (as long as there is an accepted Agreement in place).

<div class="middle-header">Applicable scenarios</div>

1. **You send a Payment Request to a [Contact](/#Zepto-API-Contacts) in order to collect funds:**
    1. Given there is an Agreement in place and the Payment Request is within the terms of the Agreement, then it will be automatically approved; **or**
    1. Given the Payment Request is **not** within the terms of the Agreement, then it will not be created; **or**
    1. There is no Agreement in place, then it will not be created.
1. **Your customer sends funds to you as a [Receivable Contact](/#add-a-receivable-contact):**
    1. A *receivable* Payment Request will be automatically created and approved to identify the movement of funds from your customer to your chosen Zepto float account.

##Lifecycle

<aside class="notice">Payment Requests generated from a customer sending you funds will always be <code>approved</code></aside>

A Payment Request can have the following statuses:

| Status | Description |
|-------|-------------|
| `pending_approval` | Waiting for the debtor to approve the Payment Request. [DEPRECATED] |
| `unverified` | Waiting for available funds response. |
| `approved` | The debtor has approved the Payment Request. |
| `declined` | The debtor has declined the Payment Request. |
| `cancelled` | The creditor has cancelled the Payment Request. |

<div class="middle-header">Prechecking</div>

When using Payment Requests to collect payments from your customer, Zepto will automatically check for available funds before **attempting to debit** the debtor. This check is only performed for contacts with an active [bank connection](/#Zepto-API-Bank-Connections).

## Request Payment

<a id="opIdMakeAPaymentRequest"></a>

> Code samples

```shell
curl --request POST \
  --url https://api.sandbox.split.cash/payment_requests \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}' \
  --header 'content-type: application/json' \
  --header 'idempotency-key: {unique-uuid-per-payment-request}' \
  --data '{"description":"Visible to both initiator and authoriser","matures_at":"2016-12-19T02:10:56.000Z","amount":99000,"authoriser_contact_id":"de86472c-c027-4735-a6a7-234366a27fc7","your_bank_account_id":"9c70871d-8e36-4c3e-8a9c-c0ee20e7c679","metadata":{"custom_key":"Custom string","another_custom_key":"Maybe a URL"}}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/payment_requests")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["content-type"] = 'application/json'
request["accept"] = 'application/json'
request["idempotency-key"] = '{unique-uuid-per-payment-request}'
request["authorization"] = 'Bearer {access-token}'
request.body = "{\"description\":\"Visible to both initiator and authoriser\",\"matures_at\":\"2016-12-19T02:10:56.000Z\",\"amount\":99000,\"authoriser_contact_id\":\"de86472c-c027-4735-a6a7-234366a27fc7\",\"your_bank_account_id\":\"9c70871d-8e36-4c3e-8a9c-c0ee20e7c679\",\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}"

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "POST",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/payment_requests",
  "headers": {
    "content-type": "application/json",
    "accept": "application/json",
    "idempotency-key": "{unique-uuid-per-payment-request}",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.write(JSON.stringify({
  description: 'Visible to both initiator and authoriser',
  matures_at: '2016-12-19T02:10:56.000Z',
  amount: 99000,
  authoriser_contact_id: 'de86472c-c027-4735-a6a7-234366a27fc7',
  your_bank_account_id: '9c70871d-8e36-4c3e-8a9c-c0ee20e7c679',
  metadata: { custom_key: 'Custom string', another_custom_key: 'Maybe a URL' }
}));
req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

payload = "{\"description\":\"Visible to both initiator and authoriser\",\"matures_at\":\"2016-12-19T02:10:56.000Z\",\"amount\":99000,\"authoriser_contact_id\":\"de86472c-c027-4735-a6a7-234366a27fc7\",\"your_bank_account_id\":\"9c70871d-8e36-4c3e-8a9c-c0ee20e7c679\",\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}"

headers = {
    'content-type': "application/json",
    'accept': "application/json",
    'idempotency-key': "{unique-uuid-per-payment-request}",
    'authorization': "Bearer {access-token}"
    }

conn.request("POST", "/payment_requests", payload, headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.post("https://api.sandbox.split.cash/payment_requests")
  .header("content-type", "application/json")
  .header("accept", "application/json")
  .header("idempotency-key", "{unique-uuid-per-payment-request}")
  .header("authorization", "Bearer {access-token}")
  .body("{\"description\":\"Visible to both initiator and authoriser\",\"matures_at\":\"2016-12-19T02:10:56.000Z\",\"amount\":99000,\"authoriser_contact_id\":\"de86472c-c027-4735-a6a7-234366a27fc7\",\"your_bank_account_id\":\"9c70871d-8e36-4c3e-8a9c-c0ee20e7c679\",\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$body = new http\Message\Body;
$body->append('{"description":"Visible to both initiator and authoriser","matures_at":"2016-12-19T02:10:56.000Z","amount":99000,"authoriser_contact_id":"de86472c-c027-4735-a6a7-234366a27fc7","your_bank_account_id":"9c70871d-8e36-4c3e-8a9c-c0ee20e7c679","metadata":{"custom_key":"Custom string","another_custom_key":"Maybe a URL"}}');

$request->setRequestUrl('https://api.sandbox.split.cash/payment_requests');
$request->setRequestMethod('POST');
$request->setBody($body);

$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'idempotency-key' => '{unique-uuid-per-payment-request}',
  'accept' => 'application/json',
  'content-type' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"strings"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/payment_requests"

	payload := strings.NewReader("{\"description\":\"Visible to both initiator and authoriser\",\"matures_at\":\"2016-12-19T02:10:56.000Z\",\"amount\":99000,\"authoriser_contact_id\":\"de86472c-c027-4735-a6a7-234366a27fc7\",\"your_bank_account_id\":\"9c70871d-8e36-4c3e-8a9c-c0ee20e7c679\",\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}")

	req, _ := http.NewRequest("POST", url, payload)

	req.Header.Add("content-type", "application/json")
	req.Header.Add("accept", "application/json")
	req.Header.Add("idempotency-key", "{unique-uuid-per-payment-request}")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`POST /payment_requests`

<aside class="notice">We strongly recommend to supply an <code>Idempotency-Key</code> header when performing this request to ensure you can safely retry the action in case of an issue. If a header value is omitted or is different to one provided previously, we will be treating a request as a new operation which may lead to a duplicate funds collection. To understand more on how to make idempotent requests, please refer to our <a href="#idempotent-requests">Idempotent requests guide</a>.</aside>

> Body parameter

```json
{
  "description": "Visible to both initiator and authoriser",
  "matures_at": "2016-12-19T02:10:56.000Z",
  "amount": 99000,
  "authoriser_contact_id": "de86472c-c027-4735-a6a7-234366a27fc7",
  "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
  "metadata": {
    "custom_key": "Custom string",
    "another_custom_key": "Maybe a URL"
  }
}
```

<h3 id="Request-Payment-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|Idempotency-Key|header|string|false|Idempotency key to support safe retries for 24h|
|body|body|[MakeAPaymentRequestRequest](#schemamakeapaymentrequestrequest)|true|No description|
|» description|body|string|true|Description visible to the initiator (payee). The first 9 characters supplied will be visible to the authoriser (payer)|
|» matures_at|body|string(date-time)|true|Date & time in UTC ISO8601 that the Payment will be processed if the request is approved. (If the request is approved after this point in time, it will be processed straight away)|
|» amount|body|integer|true|Amount in cents to pay the initiator (Min: 1 - Max: 99999999999)|
|» authoriser_contact_id|body|string|true|The Contact the payment will be requested from (`Contact.data.id`)|
|» your_bank_account_id|body|string(uuid)|false|Specify where we should settle the funds for this transaction. If omitted, your primary bank account will be used.|
|» metadata|body|object|false|Use for your custom data and certain Zepto customisations. Stored against generated transactions and included in associated webhook payloads.|

> Example responses

> 200 Response

```json
{
  "data": {
    "ref": "PR.39p1",
    "initiator_id": "ca7bc5b3-e47f-4153-96fb-bbe326b42772",
    "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
    "authoriser_id": "970e4526-67d9-4ed9-b554-f5cf390ab775",
    "authoriser_contact_id": "de86472c-c027-4735-a6a7-234366a27fc7",
    "contact_initiated": false,
    "schedule_ref": null,
    "status": "pending_approval",
    "status_reason": null,
    "matures_at": "2021-12-25T00:00:00Z",
    "responded_at": null,
    "created_at": "2021-12-19T02:10:56Z",
    "credit_ref": null,
    "payout": {
      "amount": 99000,
      "description": "Premium Package for 4",
      "matures_at": "2021-12-25T00:00:00Z"
    },
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    }
  }
}
```

<h3 id="Request Payment-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Created|[MakeAPaymentRequestResponse](#schemamakeapaymentrequestresponse)|
|422|[Unprocessable Entity](https://tools.ietf.org/html/rfc2518#section-10.3)|When a payment is requested from an Anyone Contact with no valid Agreement|[MakeAPaymentRequestWithNoAgreementResponse](#schemamakeapaymentrequestwithnoagreementresponse)|

## Get a Payment Request

<a id="opIdGetAPaymentRequest"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/payment_requests/PR.3 \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/payment_requests/PR.3")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/payment_requests/PR.3",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/payment_requests/PR.3", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/payment_requests/PR.3")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/payment_requests/PR.3');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/payment_requests/PR.3"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /payment_requests/{payment_request_ref}`

<h3 id="Get-a-Payment-Request-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|payment_request_ref|path|string|true|Single value, exact match|

> Example responses

> 200 Response

```json
{
  "data": {
    "ref": "PR.88me",
    "initiator_id": "ca7bc5b3-e47f-4153-96fb-bbe326b42772",
    "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
    "authoriser_id": "970e4526-67d9-4ed9-b554-f5cf390ab775",
    "authoriser_contact_id": "de86472c-c027-4735-a6a7-234366a27fc7",
    "contact_initiated": false,
    "schedule_ref": null,
    "status": "approved",
    "status_reason": null,
    "matures_at": "2021-11-25T00:00:00Z",
    "responded_at": "2021-11-19T02:38:04Z",
    "created_at": "2021-11-19T02:10:56Z",
    "credit_ref": "C.b6tf",
    "payout": {
      "amount": 1200,
      "description": "Xbox Live subscription",
      "matures_at": "2021-11-25T00:00:00Z"
    },
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    }
  }
}
```

<h3 id="Get a Payment Request-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[GetAPaymentRequestResponse](#schemagetapaymentrequestresponse)|

## Cancel a Payment Request

<a id="opIdCancelAPaymentRequest"></a>

> Code samples

```shell
curl --request DELETE \
  --url https://api.sandbox.split.cash/payment_requests/PR.3 \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/payment_requests/PR.3")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Delete.new(url)
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "DELETE",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/payment_requests/PR.3",
  "headers": {
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = { 'authorization': "Bearer {access-token}" }

conn.request("DELETE", "/payment_requests/PR.3", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.delete("https://api.sandbox.split.cash/payment_requests/PR.3")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/payment_requests/PR.3');
$request->setRequestMethod('DELETE');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/payment_requests/PR.3"

	req, _ := http.NewRequest("DELETE", url, nil)

	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`DELETE /payment_requests/{payment_request_ref}`

A Payment Request can be cancelled as long as the associated transaction's state is <strong>maturing</strong> or <strong>matured</strong>.

<h3 id="Cancel-a-Payment-Request-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|payment_request_ref|path|string|true|Single value, exact match|

<h3 id="Cancel a Payment Request-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|204|[No Content](https://tools.ietf.org/html/rfc7231#section-6.3.5)|No Content|None|

## List Collections

<a id="opIdListPaymentRequestCollections"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/payment_requests/collections \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/payment_requests/collections")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/payment_requests/collections",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/payment_requests/collections", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/payment_requests/collections")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/payment_requests/collections');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/payment_requests/collections"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /payment_requests/collections`

Payment Requests where you are the creditor and are collecting funds from your debtor using traditional direct-debit.

<h3 id="List-Collections-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|page|query|string|false|Page of results to return, single value, exact match|
|per_page|query|string|false|Number of results per page, single value, exact match|

> Example responses

> 200 Response

```json
{
  "data": [
    {
      "ref": "PR.84t6",
      "initiator_id": "ca7bc5b3-e47f-4153-96fb-bbe326b42772",
      "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
      "authoriser_id": "de86472c-c027-4735-a6a7-234366a27fc7",
      "authoriser_contact_id": "fb6a9252-3818-44dc-b5aa-2195391a746f",
      "contact_initiated": false,
      "schedule_ref": "PRS.89t3",
      "status": "approved",
      "status_reason": null,
      "matures_at": "2021-07-18T02:10:00Z",
      "responded_at": "2021-07-18T02:10:00Z",
      "created_at": "2021-07-18T02:10:00Z",
      "credit_ref": "C.6gr7",
      "payout": {
        "amount": 4999,
        "description": "Subscription Payment",
        "matures_at": "2021-07-18T02:10:00Z"
      }
    },
    {
      "ref": "PR.45h7",
      "initiator_id": "ca7bc5b3-e47f-4153-96fb-bbe326b42772",
      "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
      "authoriser_id": "de86472c-c027-4735-a6a7-234366a27fc7",
      "authoriser_contact_id": "fb6a9252-3818-44dc-b5aa-2195391a746f",
      "contact_initiated": false,
      "schedule_ref": null,
      "status": "pending_approval",
      "status_reason": null,
      "matures_at": "2021-03-09T16:58:00Z",
      "responded_at": null,
      "created_at": "2021-03-09T16:58:00Z",
      "credit_ref": null,
      "payout": {
        "amount": 3000,
        "description": "Membership fees",
        "matures_at": "2021-03-09T16:58:00Z"
      }
    }
  ]
}
```

<h3 id="List Collections-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[ListPaymentRequestCollectionsResponse](#schemalistpaymentrequestcollectionsresponse)|

## List Receivables

<a id="opIdListPaymentRequestReceivables"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/payment_requests/receivables \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/payment_requests/receivables")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/payment_requests/receivables",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/payment_requests/receivables", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/payment_requests/receivables")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/payment_requests/receivables');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/payment_requests/receivables"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /payment_requests/receivables`

Payment Requests where the debtor is sending you funds ([Receivable Contacts](/#add-a-receivable-contact)). This endpoint exposes all received payments.

<h3 id="List-Receivables-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|page|query|string|false|Page of results to return, single value, exact match|
|per_page|query|string|false|Number of results per page, single value, exact match|

> Example responses

> 200 Response

```json
{
  "data": [
    {
      "ref": "PR.2t65",
      "initiator_id": "ca7bc5b3-e47f-4153-96fb-bbe326b42772",
      "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
      "authoriser_id": "de86472c-c027-4735-a6a7-234366a27fc7",
      "authoriser_contact_id": "fb6a9252-3818-44dc-b5aa-2195391a746f",
      "contact_initiated": true,
      "schedule_ref": null,
      "status": "approved",
      "status_reason": null,
      "matures_at": "2021-05-12T13:43:12Z",
      "responded_at": "2021-05-12T13:43:12Z",
      "created_at": "2021-05-12T13:43:12Z",
      "credit_ref": "C.77b1",
      "payout": {
        "amount": 50000,
        "description": "Deposit to my Trading account",
        "matures_at": "2021-05-12T13:43:12Z"
      }
    },
    {
      "ref": "PR.1n644",
      "initiator_id": "ca7bc5b3-e47f-4153-96fb-bbe326b42772",
      "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
      "authoriser_id": "de86472c-c027-4735-a6a7-234366a27fc7",
      "authoriser_contact_id": "fb6a9252-3818-44dc-b5aa-2195391a746f",
      "contact_initiated": true,
      "schedule_ref": null,
      "status": "approved",
      "status_reason": null,
      "matures_at": "2021-06-01T04:34:50Z",
      "responded_at": null,
      "created_at": "2021-06-01T04:34:56Z",
      "credit_ref": "c.54r3",
      "payout": {
        "amount": 5000,
        "description": "Punting account top-up",
        "matures_at": "2021-06-01T04:34:56Z"
      }
    }
  ]
}
```

<h3 id="List Receivables-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[ListPaymentRequestReceivablesResponse](#schemalistpaymentrequestreceivablesresponse)|

<h1 id="Zepto-API-Payments">Payments</h1>

A Payment is used to disburse funds to your Contacts.

Supported payment rails:

* **NPP**: New Payments Platform (Real-time)
* **DE / BECS**: Direct Entry / Bulk Electronic Clearing System (Slower)

##Lifecycle
> Example payout reversal response

```json
{
  "data": [
  {
    "ref": "C.3",
    "parent_ref": "PB.1",
    "type": "credit",
    "category": "payout_reversal",
    "created_at": "2021-04-07T23:15:00Z",
    "matures_at": "2021-04-07T23:15:00Z",
    "cleared_at": null,
    "bank_ref": null,
    "status": "maturing",
    "status_changed_at": "2016-12-08T23:15:00Z",
    "party_contact_id": "26297f44-c5e1-40a1-9864-3e0b0754c32a",
    "party_name": "Sanford-Rees",
    "party_nickname": "sanford-rees-8",
    "description": "Payout reversal of D.1 for Sanford-Rees due to no account or incorrect account number"
      "amount": 1,
    "reversal_details": {
      "source_debit_ref": "D.1",
      "source_credit_failure": {
        "code": "E105",
        "title": "Account Not Found",
        "detail": "The target account number is incorrect."
      }
    }
  }
  ]
}
```
A Payment is simply a group of Payouts, therefore it does not have a particular status. Its Payouts however have their status regularly updated. For a list of possible Payout statuses check out the [Transactions](/#Zepto-API-Transactions).

  <aside class="notice">
    Zepto no longer supports multiple Payouts within a single Payment request. A Payment request must only contain 1 Payout object.
  </aside>

### Payout Reversal
When Zepto is unable to credit funds to a recipient, we will automatically create a payout reversal credit back to the payer. Furthermore, within the payout reversal credit, Zepto will include details in the `description` and under the `reversal_details` key as to why the original credit to the recipient failed.

## Make a Payment

<a id="opIdMakeAPayment"></a>

> Code samples

```shell
curl --request POST \
  --url https://api.sandbox.split.cash/payments \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}' \
  --header 'content-type: application/json' \
  --header 'idempotency-key: {unique-uuid-per-payment}' \
  --data '{"description":"The SuperPackage","matures_at":"2021-06-13T00:00:00Z","your_bank_account_id":"83623359-e86e-440c-9780-432a3bc3626f","channels":["new_payments_platform"],"payouts":[{"amount":30000,"description":"A tandem skydive jump SB23094","recipient_contact_id":"48b89364-1577-4c81-ba02-96705895d457","metadata":{"invoice_ref":"BILL-0001","invoice_id":"c80a9958-e805-47c0-ac2a-c947d7fd778d","custom_key":"Custom string","another_custom_key":"Maybe a URL"}}],"metadata":{"custom_key":"Custom string","another_custom_key":"Maybe a URL"}}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/payments")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["content-type"] = 'application/json'
request["accept"] = 'application/json'
request["idempotency-key"] = '{unique-uuid-per-payment}'
request["authorization"] = 'Bearer {access-token}'
request.body = "{\"description\":\"The SuperPackage\",\"matures_at\":\"2021-06-13T00:00:00Z\",\"your_bank_account_id\":\"83623359-e86e-440c-9780-432a3bc3626f\",\"channels\":[\"new_payments_platform\"],\"payouts\":[{\"amount\":30000,\"description\":\"A tandem skydive jump SB23094\",\"recipient_contact_id\":\"48b89364-1577-4c81-ba02-96705895d457\",\"metadata\":{\"invoice_ref\":\"BILL-0001\",\"invoice_id\":\"c80a9958-e805-47c0-ac2a-c947d7fd778d\",\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}],\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}"

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "POST",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/payments",
  "headers": {
    "content-type": "application/json",
    "accept": "application/json",
    "idempotency-key": "{unique-uuid-per-payment}",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.write(JSON.stringify({
  description: 'The SuperPackage',
  matures_at: '2021-06-13T00:00:00Z',
  your_bank_account_id: '83623359-e86e-440c-9780-432a3bc3626f',
  channels: [ 'new_payments_platform' ],
  payouts: [
    {
      amount: 30000,
      description: 'A tandem skydive jump SB23094',
      recipient_contact_id: '48b89364-1577-4c81-ba02-96705895d457',
      metadata: {
        invoice_ref: 'BILL-0001',
        invoice_id: 'c80a9958-e805-47c0-ac2a-c947d7fd778d',
        custom_key: 'Custom string',
        another_custom_key: 'Maybe a URL'
      }
    }
  ],
  metadata: { custom_key: 'Custom string', another_custom_key: 'Maybe a URL' }
}));
req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

payload = "{\"description\":\"The SuperPackage\",\"matures_at\":\"2021-06-13T00:00:00Z\",\"your_bank_account_id\":\"83623359-e86e-440c-9780-432a3bc3626f\",\"channels\":[\"new_payments_platform\"],\"payouts\":[{\"amount\":30000,\"description\":\"A tandem skydive jump SB23094\",\"recipient_contact_id\":\"48b89364-1577-4c81-ba02-96705895d457\",\"metadata\":{\"invoice_ref\":\"BILL-0001\",\"invoice_id\":\"c80a9958-e805-47c0-ac2a-c947d7fd778d\",\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}],\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}"

headers = {
    'content-type': "application/json",
    'accept': "application/json",
    'idempotency-key': "{unique-uuid-per-payment}",
    'authorization': "Bearer {access-token}"
    }

conn.request("POST", "/payments", payload, headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.post("https://api.sandbox.split.cash/payments")
  .header("content-type", "application/json")
  .header("accept", "application/json")
  .header("idempotency-key", "{unique-uuid-per-payment}")
  .header("authorization", "Bearer {access-token}")
  .body("{\"description\":\"The SuperPackage\",\"matures_at\":\"2021-06-13T00:00:00Z\",\"your_bank_account_id\":\"83623359-e86e-440c-9780-432a3bc3626f\",\"channels\":[\"new_payments_platform\"],\"payouts\":[{\"amount\":30000,\"description\":\"A tandem skydive jump SB23094\",\"recipient_contact_id\":\"48b89364-1577-4c81-ba02-96705895d457\",\"metadata\":{\"invoice_ref\":\"BILL-0001\",\"invoice_id\":\"c80a9958-e805-47c0-ac2a-c947d7fd778d\",\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}],\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$body = new http\Message\Body;
$body->append('{"description":"The SuperPackage","matures_at":"2021-06-13T00:00:00Z","your_bank_account_id":"83623359-e86e-440c-9780-432a3bc3626f","channels":["new_payments_platform"],"payouts":[{"amount":30000,"description":"A tandem skydive jump SB23094","recipient_contact_id":"48b89364-1577-4c81-ba02-96705895d457","metadata":{"invoice_ref":"BILL-0001","invoice_id":"c80a9958-e805-47c0-ac2a-c947d7fd778d","custom_key":"Custom string","another_custom_key":"Maybe a URL"}}],"metadata":{"custom_key":"Custom string","another_custom_key":"Maybe a URL"}}');

$request->setRequestUrl('https://api.sandbox.split.cash/payments');
$request->setRequestMethod('POST');
$request->setBody($body);

$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'idempotency-key' => '{unique-uuid-per-payment}',
  'accept' => 'application/json',
  'content-type' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"strings"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/payments"

	payload := strings.NewReader("{\"description\":\"The SuperPackage\",\"matures_at\":\"2021-06-13T00:00:00Z\",\"your_bank_account_id\":\"83623359-e86e-440c-9780-432a3bc3626f\",\"channels\":[\"new_payments_platform\"],\"payouts\":[{\"amount\":30000,\"description\":\"A tandem skydive jump SB23094\",\"recipient_contact_id\":\"48b89364-1577-4c81-ba02-96705895d457\",\"metadata\":{\"invoice_ref\":\"BILL-0001\",\"invoice_id\":\"c80a9958-e805-47c0-ac2a-c947d7fd778d\",\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}],\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}")

	req, _ := http.NewRequest("POST", url, payload)

	req.Header.Add("content-type", "application/json")
	req.Header.Add("accept", "application/json")
	req.Header.Add("idempotency-key", "{unique-uuid-per-payment}")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`POST /payments`

To enable custom payment flows, the required payment channel can be selected by setting the _channel_ attribute to one of the following combinations:

<ul>
  <li>["new_payments_platform"] - for faster payments 24/7/365</li>
  <li>["direct_entry"] - for slower traditional payments</li>
  <li>["new_payments_platform", "direct_entry"] - enables automatic channel switching if a payment fails on the NPP</li>
</ul>
<aside class="notice">We strongly recommend to supply an <code>Idempotency-Key</code> header when performing this request to ensure you can safely retry the action in case of an issue. If a header value is omitted or is different to one provided previously, we will be treating a request as a new operation which may lead to duplicate payments. To understand more on how to make idempotent requests, please refer to our <a href="#idempotent-requests">Idempotent requests guide</a>.</aside>

> Body parameter

```json
{
  "description": "The SuperPackage",
  "matures_at": "2021-06-13T00:00:00Z",
  "your_bank_account_id": "83623359-e86e-440c-9780-432a3bc3626f",
  "channels": [
    "new_payments_platform"
  ],
  "payouts": [
    {
      "amount": 30000,
      "description": "A tandem skydive jump SB23094",
      "recipient_contact_id": "48b89364-1577-4c81-ba02-96705895d457",
      "metadata": {
        "invoice_ref": "BILL-0001",
        "invoice_id": "c80a9958-e805-47c0-ac2a-c947d7fd778d",
        "custom_key": "Custom string",
        "another_custom_key": "Maybe a URL"
      }
    }
  ],
  "metadata": {
    "custom_key": "Custom string",
    "another_custom_key": "Maybe a URL"
  }
}
```

<h3 id="Make-a-Payment-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|Idempotency-Key|header|string|false|Idempotency key to support safe retries for 24h|
|body|body|[MakeAPaymentRequest](#schemamakeapaymentrequest)|true|No description|
|» description|body|string|true|User description. Only visible to the payer|
|» matures_at|body|string(date-time)|true|Date & time in UTC ISO8601 the Payment should be processed. (Can not be earlier than the start of current day in Sydney AEST/AEDT)|
|» your_bank_account_id|body|string|true|Specify where we should take the funds for this transaction. If omitted, your primary bank account will be used.|
|» channels|body|array|true|Specify the payment channel to be used, in order. (new_payments_platform, direct_entry, or both)|
|» payouts|body|[[Payout](#schemapayout)]|true|One Payout object only|
|»» Payout|body|[Payout](#schemapayout)|false|The actual Payout|
|»»» amount|body|integer|true|Amount in cents to pay the recipient|
|»»» description|body|string|true|Description that both the payer and recipient can see. For Direct Entry payments, the payout recipient will see the first 9 characters of this description. For NPP payments, the payout recipient will see the first 280 characters of this description.|
|»»» recipient_contact_id|body|string|true|Contact to pay (`Contact.data.id`)|
|»»» metadata|body|Metadata|false|Use for your custom data and certain Zepto customisations. Stored against generated transactions and included in associated webhook payloads.|
|»» metadata|body|[Metadata](#schemametadata)|false|Use for your custom data and certain Zepto customisations.|

> Example responses

> 201 Response

```json
{
  "data": {
    "ref": "PB.1",
    "your_bank_account_id": "83623359-e86e-440c-9780-432a3bc3626f",
    "channels": [
      "new_payments_platform"
    ],
    "payouts": [
      {
        "ref": "D.1",
        "recipient_contact_id": "48b89364-1577-4c81-ba02-96705895d457",
        "batch_description": "The SuperPackage",
        "matures_at": "2016-09-13T23:50:44Z",
        "created_at": "2016-09-10T23:50:44Z",
        "status": "maturing",
        "amount": 30000,
        "description": "A tandem skydive jump SB23094",
        "from_id": "83623359-e86e-440c-9780-432a3bc3626f",
        "to_id": "21066764-c103-4e7f-b436-4cee7db5f400",
        "metadata": {
          "invoice_ref": "BILL-0001",
          "invoice_id": "c80a9958-e805-47c0-ac2a-c947d7fd778d",
          "custom_key": "Custom string",
          "another_custom_key": "Maybe a URL"
        }
      }
    ],
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    }
  }
}
```

<h3 id="Make a Payment-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|201|[Created](https://tools.ietf.org/html/rfc7231#section-6.3.2)|Created|[MakeAPaymentResponse](#schemamakeapaymentresponse)|

## List all Payments

<a id="opIdListAllPayments"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/payments \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/payments")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/payments",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/payments", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/payments")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/payments');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/payments"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /payments`

<h3 id="List-all-Payments-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|page|query|string|false|Page of results to return, single value, exact match|
|per_page|query|string|false|Number of results per page, single value, exact match|

> Example responses

> 200 Response

```json
{
  "data": [
    {
      "ref": "PB.1",
      "your_bank_account_id": "83623359-e86e-440c-9780-432a3bc3626f",
      "channels": [
        "new_payments_platform",
        "direct_entry"
      ],
      "payouts": [
        {
          "ref": "D.1",
          "recipient_contact_id": "48b89364-1577-4c81-ba02-96705895d457",
          "batch_description": "This description is only available to the payer",
          "matures_at": "2016-09-13T23:50:44Z",
          "created_at": "2016-09-10T23:50:44Z",
          "status": "maturing",
          "amount": 30000,
          "description": "The recipient will see this description",
          "from_id": "83623359-e86e-440c-9780-432a3bc3626f",
          "to_id": "21066764-c103-4e7f-b436-4cee7db5f400",
          "metadata": {
            "invoice_ref": "BILL-0001",
            "invoice_id": "c80a9958-e805-47c0-ac2a-c947d7fd778d",
            "custom_key": "Custom string",
            "another_custom_key": "Maybe a URL"
          }
        },
        {
          "ref": "D.2",
          "recipient_contact_id": "dc6f1e60-3803-43ca-a200-7d641816f57f",
          "batch_description": "This description is only available to the payer",
          "matures_at": "2016-09-13T23:50:44Z",
          "created_at": "2016-09-10T23:50:44Z",
          "status": "maturing",
          "amount": 30000,
          "description": "The recipient will see this description",
          "from_id": "48b89364-1577-4c81-ba02-96705895d457",
          "to_id": "f989d9cd-87fc-4c73-b0a4-1eb0e8768d3b"
        }
      ],
      "metadata": {
        "custom_key": "Custom string",
        "another_custom_key": "Maybe a URL"
      }
    }
  ]
}
```

<h3 id="List all Payments-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[ListAllPaymentsResponse](#schemalistallpaymentsresponse)|

## Get a Payment

<a id="opIdGetAPayment"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/payments/PB.1 \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/payments/PB.1")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/payments/PB.1",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/payments/PB.1", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/payments/PB.1")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/payments/PB.1');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/payments/PB.1"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /payments/{payment_ref}`

Get a single payment by its reference

<h3 id="Get-a-Payment-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|payment_ref|path|string|true|Payment reference|

> Example responses

> 200 Response

```json
{
  "data": {
    "ref": "PB.1",
    "your_bank_account_id": "83623359-e86e-440c-9780-432a3bc3626f",
    "channels": [
      "direct_entry"
    ],
    "payouts": [
      {
        "ref": "D.1",
        "recipient_contact_id": "48b89364-1577-4c81-ba02-96705895d457",
        "batch_description": "The SuperPackage",
        "matures_at": "2016-09-13T23:50:44Z",
        "created_at": "2016-09-10T23:50:44",
        "status": "maturing",
        "amount": 30000,
        "description": "A tandem skydive jump SB23094",
        "from_id": "83623359-e86e-440c-9780-432a3bc3626f",
        "to_id": "21066764-c103-4e7f-b436-4cee7db5f400",
        "metadata": {
          "invoice_ref": "BILL-0001",
          "invoice_id": "c80a9958-e805-47c0-ac2a-c947d7fd778d",
          "custom_key": "Custom string",
          "another_custom_key": "Maybe a URL"
        }
      }
    ],
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    }
  }
}
```

<h3 id="Get a Payment-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[GetAPaymentResponse](#schemagetapaymentresponse)|

<h1 id="Zepto-API-Payouts">Payouts</h1>

This endpoint gives you some control over a transaction:

* After it has been created; and
* Before it has been submitted to the banks; or
* If it was Prefailed, due to insufficient funds, and was therefore not submitted to the banks.

<aside class="notice">
  Payments and Payment Requests are made up of individual Debits and Credits. These debits and credits
  were once referred to as Payouts [Legacy naming].
</aside>

## Retry a Prefailed Payment Request [DEPRECATED]

<a id="opIdRetryAPayout"></a>

> Code samples

```shell
curl --request POST \
  --url https://api.sandbox.split.cash/payouts/C.2/retry \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/payouts/C.2/retry")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "POST",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/payouts/C.2/retry",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("POST", "/payouts/C.2/retry", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.post("https://api.sandbox.split.cash/payouts/C.2/retry")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/payouts/C.2/retry');
$request->setRequestMethod('POST');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/payouts/C.2/retry"

	req, _ := http.NewRequest("POST", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`POST /payouts/{ref}/retry`

When debitting a Contact with an active bank connection, Zepto will first ensure that there are sufficient funds available before submitting the debit to the banks.
If a high probability of insufficient funds is detected, Zepto will not submit the transaction to the banks and will mark the transaction as <strong>Prefailed</strong>.

This endpoint allows you to retry the Payment Request without having to create a brand new transaction.

<aside class="notice">
  Rather than using this endpoint, we now recommend creating a brand new transaction as this simplifies and maintains data integrity for the lifecycle of each attempt
</aside>

<h3 id="Retry-a-Prefailed-Payment-Request-[DEPRECATED]-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|ref|path|string|true|Payment Request credit reference number e.g C.2|

> Example responses

> 200 Response

```json
{
  "data": {
    "ref": "C.2",
    "parent_ref": "PR.039a",
    "type": "credit",
    "category": "payout",
    "created_at": "2016-12-05T23:15:00Z",
    "matures_at": "2016-12-06T23:15:00Z",
    "cleared_at": null,
    "bank_ref": null,
    "status": "maturing",
    "status_changed_at": "2016-12-05T23:15:00Z",
    "party_contact_id": "33c6e31d3-1dc1-448b-9512-0320bc44fdcf",
    "party_name": "Price and Sons",
    "party_nickname": "price-and-sons-2",
    "party_bank_ref": null,
    "description": "Money for jam",
    "amount": 1
  }
}
```

<h3 id="Retry a Prefailed Payment Request [DEPRECATED]-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[RetryPayoutResponse](#schemaretrypayoutresponse)|

## Void a Payment

<a id="opIdVoidAPayment"></a>

> Code samples

```shell
curl --request DELETE \
  --url https://api.sandbox.split.cash/payouts/D.48 \
  --header 'authorization: Bearer {access-token}' \
  --header 'content-type: application/json' \
  --data false
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/payouts/D.48")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Delete.new(url)
request["content-type"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'
request.body = "false"

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "DELETE",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/payouts/D.48",
  "headers": {
    "content-type": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

payload = "false"

headers = {
    'content-type': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("DELETE", "/payouts/D.48", payload, headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.delete("https://api.sandbox.split.cash/payouts/D.48")
  .header("content-type", "application/json")
  .header("authorization", "Bearer {access-token}")
  .body("false")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$body = new http\Message\Body;
$body->append('false');

$request->setRequestUrl('https://api.sandbox.split.cash/payouts/D.48');
$request->setRequestMethod('DELETE');
$request->setBody($body);

$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'content-type' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"strings"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/payouts/D.48"

	payload := strings.NewReader("false")

	req, _ := http.NewRequest("DELETE", url, payload)

	req.Header.Add("content-type", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`DELETE /payouts/{ref}`

You can void any Payment from your account that has not yet matured.

> Body parameter

```json
false
```

<h3 id="Void-a-Payment-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|ref|path|string|true|Payment debit reference number e.g D.48|

<h3 id="Void a Payment-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|204|[No Content](https://tools.ietf.org/html/rfc7231#section-6.3.5)|No Content|None|

<h1 id="Zepto-API-Refunds">Refunds</h1>

Refunds can be issued for any successfully completed Payment Request transaction. This includes:

1. Payment Requests for direct debit payments **(Collections)**:
2. Payment Requests for funds received via DE/NPP **(Receivables)**:

This allows you to return any funds that were previously collected or received into one of your bank/float accounts.

## Issue a Refund

<a id="opIdIssueARefund"></a>

> Code samples

```shell
curl --request POST \
  --url https://api.sandbox.split.cash/credits/string/refunds \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}' \
  --header 'content-type: application/json' \
  --header 'idempotency-key: {unique-uuid-per-refund}' \
  --data '{"amount":500,"channels":["direct_entry"],"reason":"Because reason","your_bank_account_id":"9c70871d-8e36-4c3e-8a9c-c0ee20e7c679","metadata":{"custom_key":"Custom string","another_custom_key":"Maybe a URL"}}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/credits/string/refunds")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["content-type"] = 'application/json'
request["accept"] = 'application/json'
request["idempotency-key"] = '{unique-uuid-per-refund}'
request["authorization"] = 'Bearer {access-token}'
request.body = "{\"amount\":500,\"channels\":[\"direct_entry\"],\"reason\":\"Because reason\",\"your_bank_account_id\":\"9c70871d-8e36-4c3e-8a9c-c0ee20e7c679\",\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}"

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "POST",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/credits/string/refunds",
  "headers": {
    "content-type": "application/json",
    "accept": "application/json",
    "idempotency-key": "{unique-uuid-per-refund}",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.write(JSON.stringify({
  amount: 500,
  channels: [ 'direct_entry' ],
  reason: 'Because reason',
  your_bank_account_id: '9c70871d-8e36-4c3e-8a9c-c0ee20e7c679',
  metadata: { custom_key: 'Custom string', another_custom_key: 'Maybe a URL' }
}));
req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

payload = "{\"amount\":500,\"channels\":[\"direct_entry\"],\"reason\":\"Because reason\",\"your_bank_account_id\":\"9c70871d-8e36-4c3e-8a9c-c0ee20e7c679\",\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}"

headers = {
    'content-type': "application/json",
    'accept': "application/json",
    'idempotency-key': "{unique-uuid-per-refund}",
    'authorization': "Bearer {access-token}"
    }

conn.request("POST", "/credits/string/refunds", payload, headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.post("https://api.sandbox.split.cash/credits/string/refunds")
  .header("content-type", "application/json")
  .header("accept", "application/json")
  .header("idempotency-key", "{unique-uuid-per-refund}")
  .header("authorization", "Bearer {access-token}")
  .body("{\"amount\":500,\"channels\":[\"direct_entry\"],\"reason\":\"Because reason\",\"your_bank_account_id\":\"9c70871d-8e36-4c3e-8a9c-c0ee20e7c679\",\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$body = new http\Message\Body;
$body->append('{"amount":500,"channels":["direct_entry"],"reason":"Because reason","your_bank_account_id":"9c70871d-8e36-4c3e-8a9c-c0ee20e7c679","metadata":{"custom_key":"Custom string","another_custom_key":"Maybe a URL"}}');

$request->setRequestUrl('https://api.sandbox.split.cash/credits/string/refunds');
$request->setRequestMethod('POST');
$request->setBody($body);

$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'idempotency-key' => '{unique-uuid-per-refund}',
  'accept' => 'application/json',
  'content-type' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"strings"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/credits/string/refunds"

	payload := strings.NewReader("{\"amount\":500,\"channels\":[\"direct_entry\"],\"reason\":\"Because reason\",\"your_bank_account_id\":\"9c70871d-8e36-4c3e-8a9c-c0ee20e7c679\",\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}")

	req, _ := http.NewRequest("POST", url, payload)

	req.Header.Add("content-type", "application/json")
	req.Header.Add("accept", "application/json")
	req.Header.Add("idempotency-key", "{unique-uuid-per-refund}")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`POST /credits/{credit_ref}/refunds`

Certain rules apply to the issuance of a refund:
<ul>
  <li>Must be applied against a successfully cleared Payment Request (Collections or Receivables)</li>
  <li>Many refunds may be created against the original Payment Request</li>
  <li>The total refunded amount must not exceed the original value</li>
</ul>
<aside class="notice">We strongly recommend to supply an <code>Idempotency-Key</code> header when performing this request to ensure you can safely retry the action in case of an issue. If a header value is omitted or is different to one provided previously, we will be treating a request as a new operation which may lead to duplicate refunds. To understand more on how to make idempotent requests, please refer to our <a href="#idempotent-requests">Idempotent requests guide</a>.</aside>

> Body parameter

```json
{
  "amount": 500,
  "channels": [
    "direct_entry"
  ],
  "reason": "Because reason",
  "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
  "metadata": {
    "custom_key": "Custom string",
    "another_custom_key": "Maybe a URL"
  }
}
```

<h3 id="Issue-a-Refund-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|Idempotency-Key|header|string|false|Idempotency key to support safe retries for 24h|
|credit_ref|path|string|true|The credit reference number e.g C.625v|
|body|body|[IssueARefundRequest](#schemaissuearefundrequest)|true|No description|
|» amount|body|integer|true|Amount in cents refund (Min: 1 - Max: 99999999999)|
|» channels|body|array|false|Specify the payment channel to be used, in order. (new_payments_platform, direct_entry, or both)|
|» reason|body|string|false|Reason for the refund. First 9 characters are visible to both parties.|
|» your_bank_account_id|body|string(uuid)|false|Specify where we should take the funds for this transaction. If omitted, your primary bank account will be used.|
|» metadata|body|[Metadata](#schemametadata)|false|Use for your custom data and certain Zepto customisations.|

> Example responses

> 200 Response

```json
{
  "data": {
    "ref": "PRF.7f4",
    "for_ref": "C.1gf22",
    "debit_ref": "D.63hgf",
    "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
    "created_at": "2021-06-01T07:20:24Z",
    "amount": 500,
    "channels": [
      "direct_entry"
    ],
    "reason": "Subscription refund",
    "contacts": {
      "source_contact_id": "194b0237-6c2c-4705-b4fb-308274b14eda",
      "target_contact_id": "3694ff53-32ea-40ae-8392-821e48d7bd5a"
    },
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    }
  }
}
```

<h3 id="Issue a Refund-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Created|[IssueARefundResponse](#schemaissuearefundresponse)|

## List Refunds

<a id="opIdListOutgoingRefunds"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/refunds/outgoing \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/refunds/outgoing")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/refunds/outgoing",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/refunds/outgoing", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/refunds/outgoing")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/refunds/outgoing');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/refunds/outgoing"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /refunds/outgoing`

<h3 id="List-Refunds-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|page|query|string|false|Page of results to return, single value, exact match|
|per_page|query|string|false|Number of results per page, single value, exact match|

> Example responses

> 200 Response

```json
{
  "data": [
    {
      "ref": "PRF.2",
      "for_ref": "C.5",
      "debit_ref": "D.5a",
      "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
      "created_at": "2017-05-09T04:45:26Z",
      "amount": 5,
      "reason": "Because reason",
      "metadata": {
        "custom_key": "Custom string",
        "another_custom_key": "Maybe a URL"
      }
    }
  ]
}
```

<h3 id="List Refunds-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[ListOutgoingRefundsResponse](#schemalistoutgoingrefundsresponse)|

## Retrieve a Refund

<a id="opIdRetrieveARefund"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/refunds/PRF.75f \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/refunds/PRF.75f")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/refunds/PRF.75f",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/refunds/PRF.75f", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/refunds/PRF.75f")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/refunds/PRF.75f');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/refunds/PRF.75f"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /refunds/{refund_ref}`

Get a single Refund by its reference

<h3 id="Retrieve-a-Refund-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|refund_ref|path|string|true|Single value, exact match|

> Example responses

> 200 Response

```json
{
  "data": {
    "ref": "PRF.1",
    "for_ref": "C.59",
    "debit_ref": "D.hi",
    "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
    "created_at": "2017-05-08T07:20:24Z",
    "amount": 500,
    "reason": "Because reason",
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    }
  }
}
```

<h3 id="Retrieve a Refund-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[RetrieveARefundResponse](#schemaretrievearefundresponse)|

<h1 id="Zepto-API-Sandbox-Only">Sandbox Only</h1>

Special testing endpoints that only exist in the sandbox environment.

## Simulate incoming PayID payment

<a id="opIdSimulateIncomingPayIDPayment"></a>

> Code samples

```shell
curl --request POST \
  --url https://api.sandbox.split.cash/simulate/incoming_npp_payid_payment \
  --header 'authorization: Bearer {access-token}' \
  --header 'content-type: application/json' \
  --data '{"payid_email":"incoming@split.cash","amount":10000}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/simulate/incoming_npp_payid_payment")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["content-type"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'
request.body = "{\"payid_email\":\"incoming@split.cash\",\"amount\":10000}"

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "POST",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/simulate/incoming_npp_payid_payment",
  "headers": {
    "content-type": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.write(JSON.stringify({ payid_email: 'incoming@split.cash', amount: 10000 }));
req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

payload = "{\"payid_email\":\"incoming@split.cash\",\"amount\":10000}"

headers = {
    'content-type': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("POST", "/simulate/incoming_npp_payid_payment", payload, headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.post("https://api.sandbox.split.cash/simulate/incoming_npp_payid_payment")
  .header("content-type", "application/json")
  .header("authorization", "Bearer {access-token}")
  .body("{\"payid_email\":\"incoming@split.cash\",\"amount\":10000}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$body = new http\Message\Body;
$body->append('{"payid_email":"incoming@split.cash","amount":10000}');

$request->setRequestUrl('https://api.sandbox.split.cash/simulate/incoming_npp_payid_payment');
$request->setRequestMethod('POST');
$request->setBody($body);

$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'content-type' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"strings"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/simulate/incoming_npp_payid_payment"

	payload := strings.NewReader("{\"payid_email\":\"incoming@split.cash\",\"amount\":10000}")

	req, _ := http.NewRequest("POST", url, payload)

	req.Header.Add("content-type", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`POST /simulate/incoming_npp_payid_payment`

Simulate receiving a real-time PayID payment from one of your Receivable Contacts.

> Body parameter

```json
{
  "payid_email": "incoming@split.cash",
  "amount": 10000
}
```

<h3 id="Simulate-incoming-PayID-payment-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[SimulateIncomingPayIDPaymentRequest](#schemasimulateincomingpayidpaymentrequest)|true|No description|
|» payid_email|body|string|true|Receivable Contact PayID email (Min: 6 - Max: 256)|
|» amount|body|integer|true|Amount in cents (Min: 1 - Max: 99999999999)|
|» payment_description|body|string|false|Default:  "Simulated PayID payment"|
|» payment_reference|body|string|false|Default:  "simulated-payid-payment"|
|» from_bsb|body|string|false|Default: "014209"|
|» from_account_number|body|string|false|Default: "12345678"|
|» debtor_name|body|string|false|Default:  "Simulated Debtor"|
|» debtor_legal_name|body|string|false|Default:  "Simulated Debtor Pty Ltd"|

<h3 id="Simulate incoming PayID payment-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|201|[Created](https://tools.ietf.org/html/rfc7231#section-6.3.2)|Success|None|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Invalid parameters|None|

## Simulate an incoming real-time payment

<a id="opIdSimulateIncomingNPPBBANPayment"></a>

> Code samples

```shell
curl --request POST \
  --url https://api.sandbox.split.cash/simulate/incoming_npp_bban_payment \
  --header 'authorization: Bearer {access-token}' \
  --header 'content-type: application/json' \
  --data '{"to_bsb":"802919","to_account_number":"88888888","amount":10000}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/simulate/incoming_npp_bban_payment")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["content-type"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'
request.body = "{\"to_bsb\":\"802919\",\"to_account_number\":\"88888888\",\"amount\":10000}"

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "POST",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/simulate/incoming_npp_bban_payment",
  "headers": {
    "content-type": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.write(JSON.stringify({ to_bsb: '802919', to_account_number: '88888888', amount: 10000 }));
req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

payload = "{\"to_bsb\":\"802919\",\"to_account_number\":\"88888888\",\"amount\":10000}"

headers = {
    'content-type': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("POST", "/simulate/incoming_npp_bban_payment", payload, headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.post("https://api.sandbox.split.cash/simulate/incoming_npp_bban_payment")
  .header("content-type", "application/json")
  .header("authorization", "Bearer {access-token}")
  .body("{\"to_bsb\":\"802919\",\"to_account_number\":\"88888888\",\"amount\":10000}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$body = new http\Message\Body;
$body->append('{"to_bsb":"802919","to_account_number":"88888888","amount":10000}');

$request->setRequestUrl('https://api.sandbox.split.cash/simulate/incoming_npp_bban_payment');
$request->setRequestMethod('POST');
$request->setBody($body);

$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'content-type' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"strings"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/simulate/incoming_npp_bban_payment"

	payload := strings.NewReader("{\"to_bsb\":\"802919\",\"to_account_number\":\"88888888\",\"amount\":10000}")

	req, _ := http.NewRequest("POST", url, payload)

	req.Header.Add("content-type", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`POST /simulate/incoming_npp_bban_payment`

Simulate receiving a real-time payment to either a Receivable Contact or one of your float accounts, made using a BSB and account number (i.e. not via PayID).

> Body parameter

```json
{
  "to_bsb": "802919",
  "to_account_number": "88888888",
  "amount": 10000
}
```

<h3 id="Simulate-an-incoming-real-time-payment-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[SimulateIncomingNPPBBANPaymentRequest](#schemasimulateincomingnppbbanpaymentrequest)|true|No description|
|» to_bsb|body|string|true|Zepto float account BSB (usually 802919)|
|» to_account_number|body|string|true|Zepto float account number|
|» amount|body|integer|true|Amount in cents (Min: 1 - Max: 99999999999)|
|» payment_description|body|string|false|Default: "Simulated NPP payment"|
|» payment_reference|body|string|false|Default: "simulated-npp-payment"|
|» from_bsb|body|string|false|Default: "014209"|
|» from_account_number|body|string|false|Default: "12345678"|
|» debtor_name|body|string|false|Default: "Simulated Debtor"|
|» debtor_legal_name|body|string|false|Default: "Simulated Debtor Pty Ltd"|

<h3 id="Simulate an incoming real-time payment-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|201|[Created](https://tools.ietf.org/html/rfc7231#section-6.3.2)|Success|None|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Invalid parameters|None|

## Simulate an incoming DE payment

<a id="opIdSimulateIncomingDEPayment"></a>

> Code samples

```shell
curl --request POST \
  --url https://api.sandbox.split.cash/simulate/incoming_de_payment \
  --header 'authorization: Bearer {access-token}' \
  --header 'content-type: application/json' \
  --data '{"to_bsb":"802919","to_account_number":"88888888","amount":10000}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/simulate/incoming_de_payment")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["content-type"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'
request.body = "{\"to_bsb\":\"802919\",\"to_account_number\":\"88888888\",\"amount\":10000}"

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "POST",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/simulate/incoming_de_payment",
  "headers": {
    "content-type": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.write(JSON.stringify({ to_bsb: '802919', to_account_number: '88888888', amount: 10000 }));
req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

payload = "{\"to_bsb\":\"802919\",\"to_account_number\":\"88888888\",\"amount\":10000}"

headers = {
    'content-type': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("POST", "/simulate/incoming_de_payment", payload, headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.post("https://api.sandbox.split.cash/simulate/incoming_de_payment")
  .header("content-type", "application/json")
  .header("authorization", "Bearer {access-token}")
  .body("{\"to_bsb\":\"802919\",\"to_account_number\":\"88888888\",\"amount\":10000}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$body = new http\Message\Body;
$body->append('{"to_bsb":"802919","to_account_number":"88888888","amount":10000}');

$request->setRequestUrl('https://api.sandbox.split.cash/simulate/incoming_de_payment');
$request->setRequestMethod('POST');
$request->setBody($body);

$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'content-type' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"strings"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/simulate/incoming_de_payment"

	payload := strings.NewReader("{\"to_bsb\":\"802919\",\"to_account_number\":\"88888888\",\"amount\":10000}")

	req, _ := http.NewRequest("POST", url, payload)

	req.Header.Add("content-type", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`POST /simulate/incoming_de_payment`

Simulate receiving a Direct Entry payment (i.e. not a real-time payment) to either a Receivable Contact or one of your float accounts.

> Body parameter

```json
{
  "to_bsb": "802919",
  "to_account_number": "88888888",
  "amount": 10000
}
```

<h3 id="Simulate-an-incoming-DE-payment-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[SimulateIncomingDEPaymentRequest](#schemasimulateincomingdepaymentrequest)|true|No description|
|» to_bsb|body|string|true|Zepto float account BSB (usually 802919)|
|» to_account_number|body|string|true|Zepto float account number|
|» amount|body|integer|true|Amount in cents (Min: 1 - Max: 99999999999)|
|» payment_reference|body|string|false|Max 18 characters. Default: "simulated-de-pymt"|
|» from_bsb|body|string|false|Default: "014209"|
|» from_account_number|body|string|false|Default: "12345678"|
|» debtor_name|body|string|false|Max 16 characters. Default: "Simulated Debtor"|

<h3 id="Simulate an incoming DE payment-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|201|[Created](https://tools.ietf.org/html/rfc7231#section-6.3.2)|Success|None|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Invalid parameters|None|

<h1 id="Zepto-API-Transactions">Transactions</h1>

By default, the transactions endpoint provides a detailed look at all past, current and future debits & credits related to your account.

<aside class="notice">Want to also know about the debits & credits applied to the other party? No problem! Use the <code>both_parties=true</code> query string.</aside>

##Lifecycle

A transaction (debit or credit) can have the following statuses:

| Status | Description |
|--------|-------------|
| `maturing` | The maturation date has not yet been reached. |
| `matured` | The maturation date has been reached and the transaction is eligible for processing. |
| `preprocessing` | The transaction is undergoing pre-checks before being sent to the bank. |
| `processing` | The transaction has been submitted to the bank. |
| `clearing` | Waiting for confirmation from the bank that the transaction has succeeded. |
| `cleared` | The transaction is complete. |
| `rejected` | The bank has rejected the transaction due to incorrect bank account details. |
| `returned` | The transaction did not successfully clear. |
| `voided` | The transaction has been cancelled and is no longer eligible for processing. |
| `pending_verification` | The bank account must be verified before the transaction can proceed. |
| `paused` | The transaction has temporary been paused by Zepto pending internal review. |
| `prefailed` | The transaction was never submitted to the bank because we detected that there were insufficient funds. The transaction can be retried. |
| `channel_switched` | The initial payment channel has failed and the credit has automatically switched to attempt the payment using the next available channel. |
## Failure codes
> Example response

```json
{
  "data": [
    {
      "ref": "D.3",
      "parent_ref": null,
      "type": "debit",
      "category": "payout_refund",
      "created_at": "2021-04-07T23:15:00Z",
      "matures_at": "2021-04-10T23:15:00Z",
      "cleared_at": null,
      "bank_ref": null,
      "status": "returned",
      "status_changed_at": "2021-04-08T23:15:00Z",
      "failure" : {
        "code": "E251",
        "title": "Voided By Initiator",
        "detail": "The transaction was voided by its initiator.",
      },
      "failure_details": "Wrong amount - approved by Stacey"
      "party_contact_id": "26297f44-c5e1-40a1-9864-3e0b0754c32a",
      "party_name": "Sanford-Rees",
      "party_nickname": "sanford-rees-8",
      "description": null,
      "amount": 1,
      "bank_account_id": "56df206a-aaff-471a-b075-11882bc8906a"
      "channels": ["float_account"]
      "current_channel": "float_account"
    }
  ]
}
```
The rejected, returned, voided & prefailed statuses are always accompanied by a failure code, title and detail as listed below.
### DE credit failures
| Code | Title | Detail |
| ------------ | ------------- | -------------- |
| E101 | Invalid BSB Number | The BSB is not valid or is no longer active. |
| E102 | Payment Stopped | The target institution has blocked transactions to this account. Please refer to customer. |
| E103 | Account Closed | The target account is closed. |
| E104 | Customer Deceased | The target account's owner has been listed as deceased. |
| E105 | Account Not Found | The target account number cannot be found by the financial institution. |
| E106 | Refer to Customer | Usually means that there is an issue with the account receiving a credit that only the customer and their financial institution can resolve. Please refer to customer. |
| E107 | Account Deleted | The target account is deleted. |
| E108 | Invalid UserID | Please contact Zepto for further information. |
| E109 | Technically Invalid | Usually means that the account is not creditable or that the reason for failure cannot be categorised within the standard BECS return codes. Please refer to customer. |
| E150 | Voided By Admin | The transaction was voided by an administrator. |
| E151 | Voided By Initiator | The transaction was voided by its initiator. |
| E152 | Insufficient Funds | There were insufficient funds to complete the transaction. |
| E153 | System Error | The transaction was unable to complete. Please contact Zepto for assistance. |
| E154 | Account Blocked | The target account is blocked and cannot receive funds. |
| E199 | Unknown DE Error | An unknown DE error occurred. Please contact Zepto for assistance. |
### DE debit failures
| Code | Title | Detail |
| ------------ | ------------- | -------------- |
| E201 | Invalid BSB Number | The BSB is not valid or is no longer active. |
| E202 | Payment Stopped | The target institution has blocked transactions to this account. Please refer to customer. |
| E203 | Account Closed | The target account is closed. |
| E204 | Customer Deceased | The target account's owner has been listed as deceased. |
| E205 | Account Not Found | The target account number cannot be found by the financial institution. |
| E206 | Refer to Customer | Usually means insufficient funds or that the target account has breached their transaction limits. |
| E207 | Account Deleted | The target account is deleted. |
| E208 | Invalid UserID | Please contact Zepto for further information. |
| E209 | Technically Invalid | Usually means that the account is not debitable or that the reason for failure can not be categorised within the standard BECS return codes. Please refer to customer. |
| E250 | Voided By Admin | The transaction was voided by an administrator. |
| E251 | Voided By Initiator | The transaction was voided by its initiator. |
| E252 | Insufficient Funds | There were insufficient funds to complete the transaction. |
| E253 | System Error | The transaction was unable to complete. Please contact Zepto for assistance. |
| E299 | Unknown DE Error | An unknown DE error occurred. Please contact Zepto for assistance. |
### NPP credit failures
| Code | Title | Detail |
| ------------ | ------------- | -------------- |
| E301 | Upstream Network Outage | An upstream network issue occurred. Please try again later. |
| E302 | BSB Not NPP Enabled | The target BSB is not NPP enabled. Please try another channel. |
| E303 | Account Not NPP Enabled | The target account exists but cannot accept funds via the NPP. Please try another channel. |
| E304 | Account Not Found | The target account number cannot be found. |
| E305 | Intermittent Outage At Target Institution | The target financial institution is experiencing technical difficulties. Please try again later. |
| E306 | Account Closed | The target account is closed. |
| E307 | Target Institution Offline | The target financial institution is undergoing maintenance or experiencing an outage. Please try again later. |
| E308 | Account Blocked | The target account is blocked and cannot receive funds. |
| E399 | Unknown NPP Error | An unknown NPP error occurred. Please contact Zepto for assistance. |

## List all transactions

<a id="opIdListAllTransactions"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/transactions \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/transactions")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/transactions",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/transactions", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/transactions")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/transactions');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/transactions"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /transactions`

<aside class="notice">By default, Zepto will search and return all transactions created in the <strong>last 30 days</strong>. You can adjust this up to <strong>1 year</strong> by defining the <code>min_created_date</code> query string parameter defined below.</aside>

<h3 id="List-all-transactions-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|page|query|string|false|Page of results to return, single value, exact match|
|per_page|query|string|false|Number of results per page, single value, exact match|
|ref (debit or credit)|query|string|false|Single value, exact match|
|parent_ref|query|string|false|Single value, exact match|
|bank_ref|query|string|false|Single value, exact match|
|both_parties|query|boolean|false|Single value, exact match. Will also list debits & credits applied to the other party|
|status|query|array[string]|false|Multiple values, exact match|
|category|query|array[string]|false|Multiple values, exact match|
|type|query|array[string]|false|Multiple values, exact match|
|other_party|query|string|false|Single value, string search. Cannot be combine with <code>both_parties</code> query string|
|other_party_bank_ref|query|string|false|Single value, exact match|
|party_contact_id|query|string|false|Single value, exact match. Cannot be combine with <code>both_parties</code> query string|
|description|query|string|false|Single value, string search|
|min_amount|query|integer|false|Cents, single value, exact match|
|max_amount|query|integer|false|Cents, single value, exact match|
|min_created_date|query|string(date-time)|false|Date/time UTC ISO 8601 format, single value, exact match|
|max_created_date|query|string(date-time)|false|Date/time UTC ISO 8601 format, single value, exact match|
|min_matured_date|query|string(date-time)|false|Date/time UTC ISO 8601 format, single value, exact match|
|max_matured_date|query|string(date-time)|false|Date/time UTC ISO 8601 format, single value, exact match|
|min_cleared_date|query|string(date-time)|false|Date/time UTC ISO 8601 format, single value, exact match|
|max_cleared_date|query|string(date-time)|false|Date/time UTC ISO 8601 format, single value, exact match|
|min_status_changed_date|query|string(date-time)|false|Date/time UTC ISO 8601 format, single value, exact match|
|max_status_changed_date|query|string(date-time)|false|Date/time UTC ISO 8601 format, single value, exact match|

#### Enumerated Values

|Parameter|Value|
|---|---|
|status|maturing|
|status|matured|
|status|preprocessing|
|status|processing|
|status|clearing|
|status|cleared|
|status|rejected|
|status|returned|
|status|voided|
|status|pending_verification|
|status|paused|
|category|payout|
|category|payout_refund|
|category|invoice|
|type|debit|
|type|credit|

> Example responses

> 200 Response

```json
{
  "data": [
    {
      "ref": "D.3",
      "parent_ref": null,
      "type": "debit",
      "category": "payout_refund",
      "created_at": "2021-04-07T23:15:00Z",
      "matures_at": "2021-04-07T23:15:00Z",
      "cleared_at": "2021-04-10T23:15:00Z",
      "bank_ref": "DT.9a",
      "status": "cleared",
      "status_changed_at": "2021-04-10T23:15:00Z",
      "party_contact_id": "31354923-b1e9-4d65-b03c-415ead89cbf3",
      "party_name": "Sanford-Rees",
      "party_nickname": null,
      "party_bank_ref": "CT.11",
      "description": null,
      "amount": 20000,
      "bank_account_id": "56df206a-aaff-471a-b075-11882bc8906a",
      "channels": [
        "float account"
      ],
      "current_channel": "float account"
    },
    {
      "ref": "D.2",
      "parent_ref": "PB.2",
      "type": "debit",
      "category": "payout",
      "created_at": "2016-12-06T23:15:00Z",
      "matures_at": "2016-12-09T23:15:00Z",
      "cleared_at": null,
      "bank_ref": null,
      "status": "maturing",
      "status_changed_at": "2016-12-06T23:15:00Z",
      "party_contact_id": "3c6e31d3-1dc1-448b-9512-0320bc44fdcf",
      "party_name": "Gutmann-Schmidt",
      "party_nickname": null,
      "party_bank_ref": null,
      "description": "Batteries for hire",
      "amount": 2949299,
      "bank_account_id": "56df206a-aaff-471a-b075-11882bc8906a",
      "channels": [
        "float_account"
      ],
      "current_channel": "float_account"
    },
    {
      "ref": "C.2",
      "parent_ref": "PB.s0z",
      "type": "credit",
      "category": "payout",
      "created_at": "2016-12-05T23:15:00Z",
      "matures_at": "2016-12-06T23:15:00Z",
      "cleared_at": "2016-12-09T23:15:00Z",
      "bank_ref": "CT.1",
      "status": "cleared",
      "status_changed_at": "2016-12-09T23:15:00Z",
      "party_contact_id": "33c6e31d3-1dc1-448b-9512-0320bc44fdcf",
      "party_name": "Price and Sons",
      "party_nickname": "price-and-sons-2",
      "party_bank_ref": null,
      "description": "Online purchase",
      "amount": 19999,
      "bank_account_id": "c2e329ae-606f-4311-a9ab-a751baa1915c",
      "channels": [
        "new_payments_platform",
        "direct_entry"
      ],
      "current_channel": "direct_entry",
      "metadata": {
        "customer_id": "xur4492",
        "product_ref": "TSXL392110x"
      }
    }
  ]
}
```

<h3 id="List all transactions-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[ListAllTransactionsResponse](#schemalistalltransactionsresponse)|

<h1 id="Zepto-API-Transfers">Transfers</h1>

This endpoint lets you Transfer funds between any bank & float accounts registered under your Zepto account:

1. **From**: Bank Account **To**: Float Account:
  * Topping up a float account via Direct Debit
  * Up to 2 days
2. **From**: Float Account **To**: Bank Account:
  * Withdrawing from a float account
  * Will attempt NPP first and channel switch to DE if required
3. **From**: Float Account **To**: Float Account:
  * Transfer between two float accounts
  * Within seconds

## Add a Transfer

<a id="opIdAddATransfer"></a>

> Code samples

```shell
curl --request POST \
  --url https://api.sandbox.split.cash/transfers \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}' \
  --header 'content-type: application/json' \
  --data '{"from_bank_account_id":"a79423b2-3827-4cf5-9eda-dc02a298d005","to_bank_account_id":"0921a719-c79d-4ffb-91b6-1b30ab77d14d","amount":100000,"description":"Float account balance adjustment","matures_at":"2021-06-06T00:00:00Z"}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/transfers")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["content-type"] = 'application/json'
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'
request.body = "{\"from_bank_account_id\":\"a79423b2-3827-4cf5-9eda-dc02a298d005\",\"to_bank_account_id\":\"0921a719-c79d-4ffb-91b6-1b30ab77d14d\",\"amount\":100000,\"description\":\"Float account balance adjustment\",\"matures_at\":\"2021-06-06T00:00:00Z\"}"

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "POST",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/transfers",
  "headers": {
    "content-type": "application/json",
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.write(JSON.stringify({
  from_bank_account_id: 'a79423b2-3827-4cf5-9eda-dc02a298d005',
  to_bank_account_id: '0921a719-c79d-4ffb-91b6-1b30ab77d14d',
  amount: 100000,
  description: 'Float account balance adjustment',
  matures_at: '2021-06-06T00:00:00Z'
}));
req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

payload = "{\"from_bank_account_id\":\"a79423b2-3827-4cf5-9eda-dc02a298d005\",\"to_bank_account_id\":\"0921a719-c79d-4ffb-91b6-1b30ab77d14d\",\"amount\":100000,\"description\":\"Float account balance adjustment\",\"matures_at\":\"2021-06-06T00:00:00Z\"}"

headers = {
    'content-type': "application/json",
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("POST", "/transfers", payload, headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.post("https://api.sandbox.split.cash/transfers")
  .header("content-type", "application/json")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .body("{\"from_bank_account_id\":\"a79423b2-3827-4cf5-9eda-dc02a298d005\",\"to_bank_account_id\":\"0921a719-c79d-4ffb-91b6-1b30ab77d14d\",\"amount\":100000,\"description\":\"Float account balance adjustment\",\"matures_at\":\"2021-06-06T00:00:00Z\"}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$body = new http\Message\Body;
$body->append('{"from_bank_account_id":"a79423b2-3827-4cf5-9eda-dc02a298d005","to_bank_account_id":"0921a719-c79d-4ffb-91b6-1b30ab77d14d","amount":100000,"description":"Float account balance adjustment","matures_at":"2021-06-06T00:00:00Z"}');

$request->setRequestUrl('https://api.sandbox.split.cash/transfers');
$request->setRequestMethod('POST');
$request->setBody($body);

$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json',
  'content-type' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"strings"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/transfers"

	payload := strings.NewReader("{\"from_bank_account_id\":\"a79423b2-3827-4cf5-9eda-dc02a298d005\",\"to_bank_account_id\":\"0921a719-c79d-4ffb-91b6-1b30ab77d14d\",\"amount\":100000,\"description\":\"Float account balance adjustment\",\"matures_at\":\"2021-06-06T00:00:00Z\"}")

	req, _ := http.NewRequest("POST", url, payload)

	req.Header.Add("content-type", "application/json")
	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`POST /transfers`

Use this endpoint when you want to create a Transfer between any 2 of your float/bank accounts.

> Body parameter

```json
{
  "from_bank_account_id": "a79423b2-3827-4cf5-9eda-dc02a298d005",
  "to_bank_account_id": "0921a719-c79d-4ffb-91b6-1b30ab77d14d",
  "amount": 100000,
  "description": "Float account balance adjustment",
  "matures_at": "2021-06-06T00:00:00Z"
}
```

<h3 id="Add-a-Transfer-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[AddATransferRequest](#schemaaddatransferrequest)|true|No description|
|» from_bank_account_id|body|string|true|The source float/bank account (UUID)|
|» to_bank_account_id|body|string|true|The destination float/bank account (UUID)|
|» amount|body|integer|true|Amount in cents (Min: 1 - Max: 99999999999)|
|» description|body|string|true|Description for the Transfer|
|» matures_at|body|string(date-time)|true|Date & time in UTC ISO8601 the Transfer should be processed. (Can not be earlier than the start of current day in Sydney AEST/AEDT)|

> Example responses

> 201 Response

```json
{
  "data": {
    "ref": "T.11ub",
    "from_bank_account_id": "a79423b2-3827-4cf5-9eda-dc02a298d005",
    "to_bank_account_id": "0921a719-c79d-4ffb-91b6-1b30ab77d14d",
    "amount": 100000,
    "description": "Float account balance adjustment",
    "matures_at": "2021-06-06T00:00:00Z"
  }
}
```

<h3 id="Add a Transfer-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|201|[Created](https://tools.ietf.org/html/rfc7231#section-6.3.2)|Created|[AddATransferResponse](#schemaaddatransferresponse)|

## List all Transfers (Available soon)

<a id="opIdListAllTransfers"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/transfers \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/transfers")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/transfers",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/transfers", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/transfers")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/transfers');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/transfers"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /transfers`

<h3 id="List-all-Transfers-(Available-soon)-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|page|query|string|false|Page of results to return, single value, exact match|
|per_page|query|string|false|Number of results per page, single value, exact match|
|from_bank_account_id|query|string|false|Source bank/float account UUID, single value, exact match|
|to_bank_account_id|query|string|false|Target bank/float account UUID, single value, exact match|

> Example responses

> 200 Response

```json
{
  "data": [
    {
      "ref": "T.62xl",
      "from_bank_account_id": "a79423b2-3827-4cf5-9eda-dc02a298d005",
      "to_bank_account_id": "0921a719-c79d-4ffb-91b6-1b30ab77d14d",
      "amount": 47000,
      "description": "Deposit from my bank account",
      "matures_at": "2021-06-03T00:00:00Z"
    },
    {
      "ref": "T.87xp",
      "from_bank_account_id": "a79423b2-3827-4cf5-9eda-dc02a298d005",
      "to_bank_account_id": "0921a719-c79d-4ffb-91b6-1b30ab77d14d",
      "amount": 9700,
      "description": "Withdrawal June 2021",
      "matures_at": "2021-05-28T00:00:00Z"
    },
    {
      "ref": "T.87s4",
      "from_bank_account_id": "a79423b2-3827-4cf5-9eda-dc02a298d005",
      "to_bank_account_id": "0921a719-c79d-4ffb-91b6-1b30ab77d14d",
      "amount": 230,
      "description": "Transfer to my other Float account",
      "matures_at": "2021-05-03T00:00:00Z"
    }
  ]
}
```

<h3 id="List all Transfers (Available soon)-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[ListAllTransfersResponse](#schemalistalltransfersresponse)|

## Get a Transfer (Available soon)

<a id="opIdGetATransfer"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/transfers/T.11ub \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/transfers/T.11ub")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/transfers/T.11ub",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/transfers/T.11ub", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/transfers/T.11ub")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/transfers/T.11ub');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/transfers/T.11ub"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /transfers/{transfer_ref}`

Get a single transfer by its reference

<h3 id="Get-a-Transfer-(Available-soon)-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|transfer_ref|path|string|true|Transfer reference|

> Example responses

> 200 Response

```json
{
  "data": {
    "ref": "T.87xp",
    "from_bank_account_id": "a79423b2-3827-4cf5-9eda-dc02a298d005",
    "to_bank_account_id": "0921a719-c79d-4ffb-91b6-1b30ab77d14d",
    "amount": 47000,
    "description": "Deposit from my bank account",
    "matures_at": "2021-06-03T00:00:00Z"
  }
}
```

<h3 id="Get a Transfer (Available soon)-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[GetATransferResponse](#schemagetatransferresponse)|

<h1 id="Zepto-API-Unassigned-Agreements">Unassigned Agreements</h1>

An agreement with no preset authoriser that can only be accepted once and must be accepted within a predefined time period.

Unassigned Agreements are shared using the generated link available in the response body. You can then include it in an email, text message, embed it in an iFrame, etc...

Please refer to the [Unassigned Agreement](http://help.split.cash/agreements/unassigned-agreement) article in our knowledge base for more information.

## Propose an Unassigned Agreement

<a id="opIdProposeUnassignedAgreement"></a>

> Code samples

```shell
curl --request POST \
  --url https://api.sandbox.split.cash/unassigned_agreements \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}' \
  --header 'content-type: application/json' \
  --data '{"expiry_in_seconds":60,"single_use":false,"terms":{"per_payout":{"min_amount":null,"max_amount":10000},"per_frequency":{"days":7,"max_amount":1000000}},"metadata":{"custom_key":"Custom string","another_custom_key":"Maybe a URL"}}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/unassigned_agreements")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["content-type"] = 'application/json'
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'
request.body = "{\"expiry_in_seconds\":60,\"single_use\":false,\"terms\":{\"per_payout\":{\"min_amount\":null,\"max_amount\":10000},\"per_frequency\":{\"days\":7,\"max_amount\":1000000}},\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}"

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "POST",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/unassigned_agreements",
  "headers": {
    "content-type": "application/json",
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.write(JSON.stringify({
  expiry_in_seconds: 60,
  single_use: false,
  terms: {
    per_payout: { min_amount: null, max_amount: 10000 },
    per_frequency: { days: 7, max_amount: 1000000 }
  },
  metadata: { custom_key: 'Custom string', another_custom_key: 'Maybe a URL' }
}));
req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

payload = "{\"expiry_in_seconds\":60,\"single_use\":false,\"terms\":{\"per_payout\":{\"min_amount\":null,\"max_amount\":10000},\"per_frequency\":{\"days\":7,\"max_amount\":1000000}},\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}"

headers = {
    'content-type': "application/json",
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("POST", "/unassigned_agreements", payload, headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.post("https://api.sandbox.split.cash/unassigned_agreements")
  .header("content-type", "application/json")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .body("{\"expiry_in_seconds\":60,\"single_use\":false,\"terms\":{\"per_payout\":{\"min_amount\":null,\"max_amount\":10000},\"per_frequency\":{\"days\":7,\"max_amount\":1000000}},\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$body = new http\Message\Body;
$body->append('{"expiry_in_seconds":60,"single_use":false,"terms":{"per_payout":{"min_amount":null,"max_amount":10000},"per_frequency":{"days":7,"max_amount":1000000}},"metadata":{"custom_key":"Custom string","another_custom_key":"Maybe a URL"}}');

$request->setRequestUrl('https://api.sandbox.split.cash/unassigned_agreements');
$request->setRequestMethod('POST');
$request->setBody($body);

$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json',
  'content-type' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"strings"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/unassigned_agreements"

	payload := strings.NewReader("{\"expiry_in_seconds\":60,\"single_use\":false,\"terms\":{\"per_payout\":{\"min_amount\":null,\"max_amount\":10000},\"per_frequency\":{\"days\":7,\"max_amount\":1000000}},\"metadata\":{\"custom_key\":\"Custom string\",\"another_custom_key\":\"Maybe a URL\"}}")

	req, _ := http.NewRequest("POST", url, payload)

	req.Header.Add("content-type", "application/json")
	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`POST /unassigned_agreements`

Create an Unassigned Agreement.

<aside class="notice">You can set any of the term metrics to <code>null</code> if you wish them to not have a limit.</aside>

> Body parameter

```json
{
  "expiry_in_seconds": 60,
  "single_use": false,
  "terms": {
    "per_payout": {
      "min_amount": null,
      "max_amount": 10000
    },
    "per_frequency": {
      "days": 7,
      "max_amount": 1000000
    }
  },
  "metadata": {
    "custom_key": "Custom string",
    "another_custom_key": "Maybe a URL"
  }
}
```

<h3 id="Propose-an-Unassigned-Agreement-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[ProposeUnassignedAgreementRequest](#schemaproposeunassignedagreementrequest)|true|No description|
|» expiry_in_seconds|body|integer|true|The amount of time in seconds before the Unassigned Agreement can no longer be accepted.|
|» single_use|body|boolean|false|Optionally propose a single use agreement. When the Unassigned Agreement is accepted and a Payment Request is approved according to the Agreement terms, the agreement will automatically become <code>expended</code>.<br><br>The proposed agreement must have equal max/min <code>per_payout</code> amounts and <code>null</code> <code>per_frequency</code> amounts.<br><br>Furthermore, we will automatically check that the authoriser's bank account has sufficient funds to honour the agreement terms.|
|» terms|body|[Terms](#schematerms)|true|Terms|
|»» per_payout|body|[PerPayout](#schemaperpayout)|true|No description|
|»»» min_amount|body|integer|true|Minimum amount in cents a Payment Request can be in order to be auto-approved. Specify <code>null</code> for no limit.|
|»»» max_amount|body|integer|true|Maximum amount in cents a Payment Request can be in order to be auto-approved. Specify <code>null</code> for no limit.|
|»» per_frequency|body|[PerFrequency](#schemaperfrequency)|true|No description|
|»»» days|body|integer|true|Amount of days to apply against the frequency. Specify <code>null</code> for no limit.|
|»»» max_amount|body|integer|true|Maximum amount in cents the total of all PRs can be for the duration of the frequency. Specify <code>null</code> for no limit.|
|»» metadata|body|[Metadata](#schemametadata)|false|Use for your custom data and certain Zepto customisations.|

> Example responses

> 200 Response

```json
{
  "data": {
    "ref": "A.4k",
    "initiator_id": "4e2728cc-b4ba-42c2-a6c3-26a7758de58d",
    "status": "proposed",
    "responded_at": null,
    "created_at": "2017-03-20T00:53:27Z",
    "terms": {
      "per_payout": {
        "max_amount": 10000,
        "min_amount": null
      },
      "per_frequency": {
        "days": 7,
        "max_amount": 1000000
      }
    },
    "assignment_expires_at": "2017-03-20T00:54:27Z",
    "link": "https://go.sandbox.split.cash/unassigned_agreements/b61fc159-8779-4a17-a826-e398e3e7e211/invitation",
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    }
  }
}
```

<h3 id="Propose an Unassigned Agreement-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Created|[ProposeUnassignedAgreementResponse](#schemaproposeunassignedagreementresponse)|

## List all Unassigned Agreements

<a id="opIdGetUnassignedAgreements"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/unassigned_agreements \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/unassigned_agreements")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/unassigned_agreements",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/unassigned_agreements", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/unassigned_agreements")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/unassigned_agreements');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/unassigned_agreements"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /unassigned_agreements`

Will return all Unassigned Agreements that have not yet been accepted.

<h3 id="List-all-Unassigned-Agreements-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|page|query|string|false|Page of results to return, single value, exact match|
|per_page|query|string|false|Number of results per page, single value, exact match|

> Example responses

> 200 Response

```json
{
  "data": [
    {
      "ref": "A.4k",
      "initiator_id": "4e2728cc-b4ba-42c2-a6c3-26a7758de58d",
      "status": "proposed",
      "responded_at": null,
      "created_at": "2017-03-20T00:53:27Z",
      "terms": {
        "per_payout": {
          "max_amount": 10000,
          "min_amount": null
        },
        "per_frequency": {
          "days": 7,
          "max_amount": 1000000
        }
      },
      "assignment_expires_at": "2017-03-20T00:54:27Z",
      "link": "https://go.sandbox.split.cash/unassigned_agreements/b61fc159-8779-4a17-a826-e398e3e7e211/invitation"
    },
    {
      "ref": "A.7ea",
      "initiator_id": "b61fc159-8779-4a17-a826-e398e3e7e211",
      "status": "proposed",
      "responded_at": null,
      "created_at": "2017-03-21T00:53:27Z",
      "terms": {
        "per_payout": {
          "max_amount": null,
          "min_amount": null
        },
        "per_frequency": {
          "days": null,
          "max_amount": null
        }
      },
      "assignment_expires_at": "2017-03-21T00:54:27Z",
      "link": "https://go.sandbox.split.cash/unassigned_agreements/4e2728cc-b4ba-42c2-a6c3-26a7758de58d/invitation"
    }
  ]
}
```

<h3 id="List all Unassigned Agreements-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[ListUnassignedAgreementsResponse](#schemalistunassignedagreementsresponse)|

## Get an Unassigned Agreement

<a id="opIdGetAgreement"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/unassigned_agreements/A.4k \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/unassigned_agreements/A.4k")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/unassigned_agreements/A.4k",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/unassigned_agreements/A.4k", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/unassigned_agreements/A.4k")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/unassigned_agreements/A.4k');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/unassigned_agreements/A.4k"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /unassigned_agreements/{unassigned_agreement_ref}`

Get a single Unassigned Agreement by its reference.

<h3 id="Get-an-Unassigned-Agreement-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|unassigned_agreement_ref|path|string|true|Single value, exact match|

> Example responses

> 200 Response

```json
{
  "data": {
    "ref": "A.4k",
    "initiator_id": "4e2728cc-b4ba-42c2-a6c3-26a7758de58d",
    "status": "proposed",
    "responded_at": null,
    "created_at": "2017-03-20T00:53:27Z",
    "terms": {
      "per_payout": {
        "max_amount": 10000,
        "min_amount": null
      },
      "per_frequency": {
        "days": 7,
        "max_amount": 1000000
      }
    },
    "assignment_expires_at": "2017-03-20T00:54:27Z",
    "link": "https://go.sandbox.split.cash/unassigned_agreements/b61fc159-8779-4a17-a826-e398e3e7e211/invitation"
  }
}
```

<h3 id="Get an Unassigned Agreement-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[GetUnassignedAgreementResponse](#schemagetunassignedagreementresponse)|

## Delete an Unassigned Agreement

<a id="opIdDeleteUnassignedAgreement"></a>

> Code samples

```shell
curl --request DELETE \
  --url https://api.sandbox.split.cash/unassigned_agreements/A.2 \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/unassigned_agreements/A.2")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Delete.new(url)
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "DELETE",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/unassigned_agreements/A.2",
  "headers": {
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = { 'authorization': "Bearer {access-token}" }

conn.request("DELETE", "/unassigned_agreements/A.2", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.delete("https://api.sandbox.split.cash/unassigned_agreements/A.2")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/unassigned_agreements/A.2');
$request->setRequestMethod('DELETE');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/unassigned_agreements/A.2"

	req, _ := http.NewRequest("DELETE", url, nil)

	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`DELETE /unassigned_agreements/{unassigned_agreement_ref}`

An Unassigned Agreement can be deleted at anytime as long as it has not yet been assigned an authoriser.

<h3 id="Delete-an-Unassigned-Agreement-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|unassigned_agreement_ref|path|string|true|Single value, exact match|

<h3 id="Delete an Unassigned Agreement-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|204|[No Content](https://tools.ietf.org/html/rfc7231#section-6.3.5)|No Content|None|

<h1 id="Zepto-API-Users">Users</h1>

All about the currently authenticated user.

## Get user details

<a id="opIdGetUserDetails"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/user \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/user")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/user",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/user", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/user")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/user');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/user"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /user`

> Example responses

> 200 Response

```json
{
  "data": {
    "first_name": "Bear",
    "last_name": "Dog",
    "mobile_phone": "0456945832",
    "email": "bear@dog.com",
    "account": {
      "name": "Dog Bones Inc",
      "nickname": "dog-bones-inc",
      "abn": "129959040",
      "phone": "0418495033",
      "street_address": "98 Acme Avenue",
      "suburb": "Lead",
      "state": "NSW",
      "postcode": "2478"
    }
  }
}
```

<h3 id="Get user details-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[GetUserDetailsResponse](#schemagetuserdetailsresponse)|

<h1 id="Zepto-API-Webhooks">Webhooks</h1>

## List all webhooks

<a id="opIdGetWebhooks"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/webhooks \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/webhooks")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/webhooks",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/webhooks", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/webhooks")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/webhooks');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/webhooks"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /webhooks`

List all your application's webhook configurations.

> Example responses

> 200 Response

```json
{
  "data": [
    {
      "id": "13bd760e-447f-4225-b801-0777a15da131",
      "url": "https://webhook.site/a9a3033b-90eb-44af-9ba3-29972435d10e",
      "signature_secret": "8fad2f5570e6bf0351728f727c5a8c770dda646adde049b866a7800d59",
      "events": [
        "debit.cleared",
        "credit.cleared"
      ]
    }
  ]
}
```

<h3 id="List all webhooks-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[ListAllWebhooksResponse](#schemalistallwebhooksresponse)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found|None|

## List deliveries for a webhook

<a id="opIdGetWebhookDeliveries"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/webhooks/31918dce-2dc3-405b-8d3c-fd3901b17e9f/deliveries \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/webhooks/31918dce-2dc3-405b-8d3c-fd3901b17e9f/deliveries")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/webhooks/31918dce-2dc3-405b-8d3c-fd3901b17e9f/deliveries",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/webhooks/31918dce-2dc3-405b-8d3c-fd3901b17e9f/deliveries", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/webhooks/31918dce-2dc3-405b-8d3c-fd3901b17e9f/deliveries")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/webhooks/31918dce-2dc3-405b-8d3c-fd3901b17e9f/deliveries');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/webhooks/31918dce-2dc3-405b-8d3c-fd3901b17e9f/deliveries"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /webhooks/{webhook_id}/deliveries`

NOTE: Webhook deliveries are stored for 30 days.

<h3 id="List-deliveries-for-a-webhook-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|webhook_id|path|string|true|Single value, exact match|
|ref|query|string|false|Filter deliveries by ref (`WebhookDelivery.data.ref`), single value, exact match|
|per_page|query|string|false|Number of results per page, single value, exact match|
|starting_after|query|string(uuid)|false|Display all webhook deliveries after this webhook delivery offset UUID, single value, exact match|
|event_type|query|string|false|See ([Data schemas](/#data-schemas)) for a list of possible values, single value, exact match|
|since|query|string(date-time)|false|Display all webhook deliveries after this date. Date/time UTC ISO 8601 format, single value, exact match|
|response_status_code|query|array[string]|false|Single value / multiple values separated by commas|
|state|query|array[string]|false|Filter deliveries by state, single value / multiple values separated by commas. See [Our delivery promise](#our-delivery-promises)|

#### Enumerated Values

|Parameter|Value|
|---|---|
|event_type|See ([Data schemas](/#data-schemas))|
|response_status_code|2xx|
|response_status_code|4xx|
|response_status_code|5xx|
|state|pending|
|state|completed|
|state|retrying|
|state|failed|

> Example responses

> 200 Response

```json
{
  "data": [
    {
      "id": "957d40a4-80f5-4dd2-8ada-8242d5ad66c1",
      "event_type": "payout_request.added",
      "state": "completed",
      "response_status_code": 200,
      "created_at": "2021-09-02T02:24:50.000Z",
      "payload_data_summary": [
        {
          "ref": "PR.ct5b"
        }
      ]
    },
    {
      "id": "29bb9835-7c69-4ecb-bf96-197d089d0ec3",
      "event_type": "creditor_debit.scheduled",
      "state": "completed",
      "response_status_code": 200,
      "created_at": "2021-09-02T02:24:50.000Z",
      "payload_data_summary": [
        {
          "ref": "D.hyy9"
        },
        {
          "ref": "D.6st93"
        }
      ]
    }
  ]
}
```

<h3 id="List deliveries for a webhook-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[GetWebhookDeliveriesResponse](#schemagetwebhookdeliveriesresponse)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found|None|

## Get a Webhook Delivery

<a id="opIdGetAWebhookDelivery"></a>

> Code samples

```shell
curl --request GET \
  --url https://api.sandbox.split.cash/webhook_deliveries/31918dce-2dc3-405b-8d3c-fd3901b17e9f \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/webhook_deliveries/31918dce-2dc3-405b-8d3c-fd3901b17e9f")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "GET",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/webhook_deliveries/31918dce-2dc3-405b-8d3c-fd3901b17e9f",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("GET", "/webhook_deliveries/31918dce-2dc3-405b-8d3c-fd3901b17e9f", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.get("https://api.sandbox.split.cash/webhook_deliveries/31918dce-2dc3-405b-8d3c-fd3901b17e9f")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/webhook_deliveries/31918dce-2dc3-405b-8d3c-fd3901b17e9f');
$request->setRequestMethod('GET');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/webhook_deliveries/31918dce-2dc3-405b-8d3c-fd3901b17e9f"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`GET /webhook_deliveries/{id}`

Get a single webhook delivery by ID.

<h3 id="Get-a-Webhook-Delivery-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|id|path|string(UUID)|true|WebhookDelivery ID (`WebhookDelivery.data.id`)|

> Example responses

> 200 Response

```json
{
  "data": {
    "id": "957d40a4-80f5-4dd2-8ada-8242d5ad66c1",
    "webhook_id": "13bd760e-447f-4225-b801-0777a15da131",
    "event_type": "payout_request.added",
    "state": "completed",
    "payload": {
      "data": [
        {
          "ref": "PR.ct5b",
          "payout": {
            "amount": 1501,
            "matures_at": "2021-09-02T02:24:49.000Z",
            "description": "Payment from Incoming Test Payment Contact 014209 12345678 (Test Payment)"
          },
          "status": "approved",
          "created_at": "2021-09-02T02:24:49.000Z",
          "credit_ref": "C.p2rt",
          "matures_at": "2021-09-02T02:24:49.000Z",
          "initiator_id": "b50a6e92-a5e1-4175-b560-9e4c9a9bb4b9",
          "responded_at": "2021-09-02T02:24:49.000Z",
          "schedule_ref": null,
          "authoriser_id": "780f186c-80fd-42b9-97d5-650d99a0bc99",
          "status_reason": null,
          "your_bank_account_id": "b50a6e92-a5e1-4175-b560-9e4c9a9bb4b9",
          "authoriser_contact_id": "590be205-6bae-4070-a9af-eb50d514cec5",
          "authoriser_contact_initiated": true
        },
        {
          "event": {
            "at": "2021-09-02T02:24:49.000Z",
            "who": {
              "account_id": "20f4e3f8-2efc-48a9-920b-541515f1c9e3",
              "account_type": "Account",
              "bank_account_id": "b50a6e92-a5e1-4175-b560-9e4c9a9bb4b9",
              "bank_account_type": "BankAccount"
            },
            "type": "payment_request.added"
          }
        }
      ]
    }
  },
  "response_status_code": 200,
  "created_at": "2021-09-02T02:24:50.000Z"
}
```

<h3 id="Get a Webhook Delivery-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[GetAWebhookDeliveryResponse](#schemagetawebhookdeliveryresponse)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found|None|

## Resend a Webhook Delivery

<a id="opIdResendAWebhookDelivery"></a>

> Code samples

```shell
curl --request POST \
  --url https://api.sandbox.split.cash/webhook_deliveries/31918dce-2dc3-405b-8d3c-fd3901b17e9f/redeliver \
  --header 'accept: application/json' \
  --header 'authorization: Bearer {access-token}'
```

```ruby
require 'uri'
require 'net/http'

url = URI("https://api.sandbox.split.cash/webhook_deliveries/31918dce-2dc3-405b-8d3c-fd3901b17e9f/redeliver")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["accept"] = 'application/json'
request["authorization"] = 'Bearer {access-token}'

response = http.request(request)
puts response.read_body
```

```javascript--node
var http = require("https");

var options = {
  "method": "POST",
  "hostname": "api.sandbox.split.cash",
  "port": null,
  "path": "/webhook_deliveries/31918dce-2dc3-405b-8d3c-fd3901b17e9f/redeliver",
  "headers": {
    "accept": "application/json",
    "authorization": "Bearer {access-token}"
  }
};

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();
```

```python
import http.client

conn = http.client.HTTPSConnection("api.sandbox.split.cash")

headers = {
    'accept': "application/json",
    'authorization': "Bearer {access-token}"
    }

conn.request("POST", "/webhook_deliveries/31918dce-2dc3-405b-8d3c-fd3901b17e9f/redeliver", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))
```

```java
HttpResponse<String> response = Unirest.post("https://api.sandbox.split.cash/webhook_deliveries/31918dce-2dc3-405b-8d3c-fd3901b17e9f/redeliver")
  .header("accept", "application/json")
  .header("authorization", "Bearer {access-token}")
  .asString();
```

```php
<?php

$client = new http\Client;
$request = new http\Client\Request;

$request->setRequestUrl('https://api.sandbox.split.cash/webhook_deliveries/31918dce-2dc3-405b-8d3c-fd3901b17e9f/redeliver');
$request->setRequestMethod('POST');
$request->setHeaders(array(
  'authorization' => 'Bearer {access-token}',
  'accept' => 'application/json'
));

$client->enqueue($request)->send();
$response = $client->getResponse();

echo $response->getBody();
```

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://api.sandbox.split.cash/webhook_deliveries/31918dce-2dc3-405b-8d3c-fd3901b17e9f/redeliver"

	req, _ := http.NewRequest("POST", url, nil)

	req.Header.Add("accept", "application/json")
	req.Header.Add("authorization", "Bearer {access-token}")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```

`POST /webhook_deliveries/{id}/redeliver`

Use this endpoint to resend a failed webhook delivery.

<h3 id="Resend-a-Webhook-Delivery-parameters" class="parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|id|path|string(UUID)|true|WebhookDelivery ID (`WebhookDelivery.data.id`)|

> Example responses

> 202 Response

```json
{
  "data": {
    "id": "957d40a4-80f5-4dd2-8ada-8242d5ad66c1",
    "webhook_id": "13bd760e-447f-4225-b801-0777a15da131",
    "state": "pending"
  }
}
```

<h3 id="Resend a Webhook Delivery-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|202|[Accepted](https://tools.ietf.org/html/rfc7231#section-6.3.3)|Accepted|[RedeliverAWebhookDeliveryResponse](#schemaredeliverawebhookdeliveryresponse)|

# Schemas

## GetAgreementResponse

<a id="schemagetagreementresponse"></a>

```json
{
  "data": {
    "ref": "A.2",
    "initiator_id": "4e2728cc-b4ba-42c2-a6c3-26a7758de58d",
    "authoriser_id": "8df89c16-330f-462b-8891-808d7bdceb7f",
    "contact_id": "0d290763-bd5a-4b4d-a8ce-06c64c4a697b",
    "bank_account_id": "fb9381ec-22af-47fd-8998-804f947aaca3",
    "status": "approved",
    "status_reason": null,
    "responded_at": "2017-03-20T02:13:11Z",
    "created_at": "2017-03-20T00:53:27Z",
    "terms": {
      "per_payout": {
        "max_amount": 10000,
        "min_amount": 1
      },
      "per_frequency": {
        "days": 7,
        "max_amount": 1000000
      }
    }
  }
}
```

### Properties

*Get an Agreement (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|true|No description|
|» ref|string|true|The Agreement reference (Min: 3 - Max: 18)|
|» initiator_id|string(uuid)|true|Your Zepto account ID|
|» authoriser_id|string(uuid)|true|The authoriser's account ID (AnyoneAccount)|
|» contact_id|string(uuid)|true|The contact ID representing the authoriser within Zepto|
|» bank_account_id|string(uuid)|true|The authoriser's bank account ID|
|» status|string|true|The status of the Agreement|
|» status_reason|string|true|The reason the agreement was cancelled. This is a free text field.|
|» responded_at|string(date-time)|true|The date-time when the Agreement status changed|
|» created_at|string(date-time)|true|The date-time when the Agreement was created|
|» terms|[Terms](#schematerms)|true|No description|
|» metadata|object|false|Your custom keyed data|

#### Enumerated Values

|Property|Value|
|---|---|
|status|proposed|
|status|accepted|
|status|cancelled|
|status|declined|
|status|expended|

## ListOutgoingAgreementsResponse

<a id="schemalistoutgoingagreementsresponse"></a>

```json
{
  "data": [
    {
      "ref": "A.4",
      "initiator_id": "4e2728cc-b4ba-42c2-a6c3-26a7758de58d",
      "authoriser_id": "8df89c16-330f-462b-8891-808d7bdceb7f",
      "contact_id": "a80ac411-c8fb-45c0-9557-607c54649907",
      "bank_account_id": "fa80ac411-c8fb-45c0-9557-607c54649907",
      "status": "proposed",
      "status_reason": null,
      "responded_at": null,
      "created_at": "2017-03-20T00:53:27Z",
      "terms": {
        "per_payout": {
          "max_amount": 10000,
          "min_amount": 1
        },
        "per_frequency": {
          "days": 7,
          "max_amount": 1000000
        }
      }
    },
    {
      "ref": "A.3",
      "initiator_id": "4e2728cc-b4ba-42c2-a6c3-26a7758de58d",
      "authoriser_id": "56df206a-aaff-471a-b075-11882bc8906a",
      "contact_id": "a80ac411-c8fb-45c0-9557-607c54649907",
      "bank_account_id": "fa80ac411-c8fb-45c0-9557-607c54649907",
      "status": "proposed",
      "status_reason": null,
      "responded_at": null,
      "created_at": "2017-03-16T22:51:48Z",
      "terms": {
        "per_payout": {
          "max_amount": 5000,
          "min_amount": 0
        },
        "per_frequency": {
          "days": "1",
          "max_amount": 10000
        }
      }
    }
  ]
}
```

### Properties

*List outgoing Agreements (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|[object]|true|No description|

## ListAllBankAccountsResponse

<a id="schemalistallbankaccountsresponse"></a>

```json
{
  "data": [
    {
      "id": "6a7ed958-f1e8-42dc-8c02-3901d7057357",
      "branch_code": "493192",
      "bank_name": "National Australia Bank",
      "account_number": "3993013",
      "status": "active",
      "title": "AU.493192.3993013",
      "available_balance": null
    },
    {
      "id": "56df206a-aaff-471a-b075-11882bc8906a",
      "branch_code": "302193",
      "bank_name": "National Australia Bank",
      "account_number": "119302",
      "status": "active",
      "title": "Trust Account",
      "available_balance": null
    },
    {
      "id": "ab3de19b-709b-4a41-82a5-3b43b3dc58c9",
      "branch_code": "802919",
      "bank_name": "Zepto Float Account",
      "account_number": "1748212",
      "status": "active",
      "title": "Float Account",
      "available_balance": 10000,
      "payid_configs": {
        "email_domain": "pay.zepto.com.au",
        "pooling_state": "disabled",
        "max_pool_size": 10,
        "current_pool_size": 1
      }
    }
  ]
}
```

### Properties

*List all Bank Accounts (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|[object]|true|No description|

## ListAllBankConnectionsResponse

<a id="schemalistallbankconnectionsresponse"></a>

```json
{
  "data": [
    {
      "id": "fb497754-87e2-407d-871f-32aec39d09d4",
      "provider_name": "split",
      "state": "active",
      "refreshed_at": "2020-02-13T09:05:00Z",
      "removed_at": null,
      "failure_reason": null,
      "institution": {
        "short_name": "CBA",
        "full_name": "Commonwealth Bank of Australia"
      },
      "contact": {
        "id": "626e15b1-aa4a-496e-b5d6-3f8c1a6d2189",
        "name": "George Morissette",
        "email": "randy@windler.net"
      },
      "links": {
        "update_bank_connection": "http://go.split.cash/authorise_bank_connections/williams-and-sons-5/fb497754-87e2-407d-871f-32aec39d09d4"
      }
    },
    {
      "id": "ddbee875-7344-4d74-9503-6233149fe1a0",
      "provider_name": "split",
      "state": "credentials_invalid",
      "refreshed_at": "2020-02-13T09:05:00Z",
      "removed_at": null,
      "failure_reason": null,
      "institution": {
        "short_name": "CBA",
        "full_name": "Commonwealth Bank of Australia"
      },
      "contact": {
        "id": "72e37667-6364-440f-b1bd-56df5654e258",
        "name": "Joel Boyle",
        "email": "travis@hermanntorp.net"
      },
      "links": {
        "update_bank_connection": "http://go.split.cash/authorise_bank_connections/williams-and-sons-5/ddbee875-7344-4d74-9503-6233149fe1a0"
      }
    }
  ]
}
```

### Properties

*List all Bank Connections (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|[object]|true|No description|

## CreateOpenAgreementRequest

<a id="schemacreateopenagreementrequest"></a>

```json
{
  "title": "Subscription Plan A",
  "terms": {
    "per_payout": {
      "min_amount": null,
      "max_amount": 10000
    },
    "per_frequency": {
      "days": 7,
      "max_amount": 1000000
    }
  },
  "metadata": {
    "custom_key": "Custom string",
    "another_custom_key": "Maybe a URL"
  }
}
```

### Properties

*Create an Open Agreement (request)*

|Name|Type|Required|Description|
|---|---|---|---|
|title|string|true|Title of the Open Agreement (Visible to authorisers)|
|terms|[Terms](#schematerms)|true|No description|
|metadata|[Metadata](#schemametadata)|false|No description|

## Terms

<a id="schematerms"></a>

```json
{
  "per_payout": {
    "min_amount": 0,
    "max_amount": 10000
  },
  "per_frequency": {
    "days": 7,
    "max_amount": 1000000
  }
}
```

### Properties

*Agreement terms*

|Name|Type|Required|Description|
|---|---|---|---|
|per_payout|[PerPayout](#schemaperpayout)|true|No description|
|per_frequency|[PerFrequency](#schemaperfrequency)|true|No description|

## PerPayout

<a id="schemaperpayout"></a>

```json
{
  "min_amount": 0,
  "max_amount": 10000
}
```

### Properties

*Per payout terms*

|Name|Type|Required|Description|
|---|---|---|---|
|min_amount|integer|true|Minimum amount in cents a Payment Request can be in order to be auto-approved. Specify <code>null</code> for no limit.|
|max_amount|integer|true|Maximum amount in cents a Payment Request can be in order to be auto-approved. Specify <code>null</code> for no limit.|

## PerFrequency

<a id="schemaperfrequency"></a>

```json
{
  "days": 7,
  "max_amount": 1000000
}
```

### Properties

*Per frequency terms*

|Name|Type|Required|Description|
|---|---|---|---|
|days|integer|true|Amount of days to apply against the frequency. Specify <code>null</code> for no limit.|
|max_amount|integer|true|Maximum amount in cents the total of all PRs can be for the duration of the frequency. Specify <code>null</code> for no limit.|

## CreateOpenAgreementResponse

<a id="schemacreateopenagreementresponse"></a>

```json
{
  "data": {
    "ref": "OA.1",
    "title": "Subscription Plan A",
    "status": "active",
    "created_at": "2017-03-20T00:53:27Z",
    "terms": {
      "per_payout": {
        "min_amount": null,
        "max_amount": 10000
      },
      "per_frequency": {
        "days": 7,
        "max_amount": 1000000
      }
    },
    "link": "https://go.sandbox.split.cash/open_agreements/aecff76d-13e0-4e17-b7c5-844ae07fa675/agreements/invitation"
  }
}
```

### Properties

*Create an Open Agreement (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|true|No description|

## ListAllOpenAgreementsResponse

<a id="schemalistallopenagreementsresponse"></a>

```json
{
  "data": [
    {
      "ref": "OA.1",
      "title": "Subscription Plan A",
      "status": "active",
      "created_at": "2017-03-20T00:53:27Z",
      "terms": {
        "per_payout": {
          "max_amount": 10000,
          "min_amount": null
        },
        "per_frequency": {
          "days": 7,
          "max_amount": 1000000
        }
      },
      "link": "https://go.sandbox.split.cash/open_agreements/2e002c0b-ffaf-44eb-a35c-15fa384ddde1/agreements/invitation"
    },
    {
      "ref": "OA.2",
      "title": "Subscription Plan B",
      "status": "closed",
      "created_at": "2017-03-20T00:53:27Z",
      "terms": {
        "per_payout": {
          "max_amount": 10000,
          "min_amount": null
        },
        "per_frequency": {
          "days": null,
          "max_amount": null
        }
      },
      "link": "https://go.sandbox.split.cash/open_agreements/948e3662-154d-42d1-bdc9-a05c251d3981/agreements/invitation"
    }
  ]
}
```

### Properties

*List all Open Agreements (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|[object]|true|No description|

## ActivateOpenAgreementResponse

<a id="schemaactivateopenagreementresponse"></a>

```json
{
  "data": {
    "ref": "OA.1",
    "title": "Subscription Plan A",
    "status": "active",
    "created_at": "2017-03-20T00:53:27Z",
    "terms": {
      "per_payout": {
        "max_amount": 10000,
        "min_amount": null
      },
      "per_frequency": {
        "days": 7,
        "max_amount": 1000000
      }
    },
    "link": "https://go.sandbox.split.cash/open_agreements/2e002c0b-ffaf-44eb-a35c-15fa384ddde1/agreements/invitation"
  }
}
```

### Properties

*Activate Open Agreement Request (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|true|No description|

## CloseOpenAgreementResponse

<a id="schemacloseopenagreementresponse"></a>

```json
{
  "data": {
    "ref": "OA.1",
    "title": "Subscription Plan A",
    "status": "closed",
    "created_at": "2017-03-20T00:53:27Z",
    "terms": {
      "per_payout": {
        "max_amount": 10000,
        "min_amount": null
      },
      "per_frequency": {
        "days": 7,
        "max_amount": 1000000
      }
    },
    "link": "https://go.sandbox.split.cash/open_agreements/2e002c0b-ffaf-44eb-a35c-15fa384ddde1/agreements/invitation"
  }
}
```

### Properties

*Close Open Agreement Request (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|true|No description|

## AddAReceivableContactRequest

<a id="schemaaddareceivablecontactrequest"></a>

```json
{
  "name": "Delphine Jestin",
  "email": "delphine@gmail.com",
  "payid_email": "delphine_123@merchant.com.au",
  "metadata": {
    "custom_key": "Custom string",
    "another_custom_key": "Maybe a URL"
  }
}
```

### Properties

*Add a Receivable Contact (request)*

|Name|Type|Required|Description|
|---|---|---|---|
|name|string|true|Contact name (Min: 3 - Max: 140)|
|email|string|true|Contact email (Min: 6 - Max: 256)|
|payid_email|string|false|Contact PayID email (Min: 6 - Max: 256)|
|payid_email_domain|string|false|PayID pool email domain (Min: 3 - Max: 254)|
|metadata|[Metadata](#schemametadata)|false|No description|

## AddAReceivableContactResponse

<a id="schemaaddareceivablecontactresponse"></a>

```json
{
  "data": {
    "id": "6a7ed958-f1e8-42dc-8c02-3901d7057357",
    "name": "Delphine Jestin",
    "email": "delphine@gmail.com",
    "type": "anyone",
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    },
    "bank_account": {
      "id": "55afddde-4296-4daf-8e49-7ba481ef9608",
      "account_number": "1408281",
      "branch_code": "802919",
      "bank_name": "Zepto Float Account",
      "state": "active",
      "iav_provider": null,
      "iav_status": null,
      "blocks": {
        "debits_blocked": false,
        "credits_blocked": false
      }
    },
    "anyone_account": {
      "id": "77be6ecc-5fa7-454b-86d6-02a5f147878d"
    },
    "payid_details": {
      "alias_value": "delphine_123@merchant.com.au",
      "alias_type": "email",
      "alias_name": "your merchant's alias_name",
      "state": "pending"
    }
  }
}
```

### Properties

*Add a Receivable Contact (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|false|No description|
|» id|string(uuid)|false|No description|
|» name|string|false|Contact name (Min: 3 - Max: 140)|
|» email|string|false|Contact email (Min: 6 - Max: 256)|
|» type|string|false|Fixed to 'anyone'|
|» metadata|[Metadata](#schemametadata)|false|No description|
|» bank_account|object|false|No description|
|»» id|string(uuid)|false|No description|
|»» account_number|string|false|Zepto generated account number (Min: 5 - Max: 9)|
|»» branch_code|string|false|Zepto branch code (Min: 6 - Max: 6)|
|»» bank_name|string|false|Fixed to 'Zepto Float Acount'|
|»» state|string|false|Fixed to 'Active'|
|»» iav_provider|string|false|Always null|
|»» iav_status|string|false|Always null|
|»» blocks|object|false|No description|
|»»» debits_blocked|boolean|false|Used by Zepto admins. Defines whether the bank account is blocked from being debited|
|»»» credits_blocked|boolean|false|Used by Zepto admins. Defined Whether this bank account is blocked from being credited|
|»» anyone_account|object|false|No description|
|»»» id|string(uuid)|false|No description|
|»» payid_details|object|false|No description|
|»»» alias_value|string(email)|false|The PayID email|
|»»» alias_type|string|false|Type of PayID. Fixed to `email`|
|»»» alias_name|string|false|Your merchant's alias_name|
|»»» state|string|false|Pending -> Active or Failed -> Deregistered (Contact removed)|

#### Enumerated Values

|Property|Value|
|---|---|
|state|active|
|state|removed|
|state|pending|
|state|active|
|state|failed|
|state|deregistered|

## ListAllContactsResponse

<a id="schemalistallcontactsresponse"></a>

```json
{
  "data": [
    {
      "id": "6a7ed958-f1e8-42dc-8c02-3901d7057357",
      "name": "Outstanding Tours Pty Ltd",
      "email": "accounts@outstandingtours.com.au",
      "type": "Zepto account",
      "bank_account": {
        "id": "095c5ab7-7fa8-40fd-b317-cddbbf4c8fbc",
        "account_number": "494307",
        "branch_code": "435434",
        "bank_name": "National Australia Bank",
        "state": "active",
        "iav_provider": "split",
        "iav_status": "active",
        "blocks": {
          "debits_blocked": false,
          "credits_blocked": false
        }
      },
      "bank_connection": {
        "id": "c397645b-bd4f-4fc6-b1fe-4993fef6c3c7"
      }
    },
    {
      "id": "49935c67-c5df-4f00-99f4-1413c18a89a0",
      "name": "Adventure Dudes Pty Ltd",
      "email": "accounts@adventuredudes.com.au",
      "type": "Zepto account",
      "bank_account": {
        "id": "861ff8e4-7acf-4897-9e53-e7c5ae5f7cc0",
        "account_number": "4395959",
        "branch_code": "068231",
        "bank_name": "National Australia Bank",
        "state": "active",
        "iav_provider": "split",
        "iav_status": "credentials_invalid",
        "blocks": {
          "debits_blocked": false,
          "credits_blocked": false
        }
      },
      "bank_connection": {
        "id": "c397645b-bd4f-4fc6-b1fe-4993fef6c3c7"
      }
    },
    {
      "id": "eb3266f9-e172-4b6c-b802-fe5ac4d3250a",
      "name": "Surfing World Pty Ltd",
      "email": "accounts@surfingworld.com.au",
      "type": "Zepto account",
      "bank_account": {
        "id": null,
        "account_number": null,
        "branch_code": null,
        "bank_name": null,
        "state": "disabled",
        "iav_provider": null,
        "iav_status": null,
        "blocks": {
          "debits_blocked": false,
          "credits_blocked": false
        }
      },
      "links": {
        "add_bank_connection": "https://go.sandbox.split.cash/invite_contact/thomas-morgan-1/1030bfef-cef5-4938-b10b-5841cafafc80"
      }
    },
    {
      "id": "6a7ed958-f1e8-42dc-8c02-3901d7057357",
      "name": "Hunter Thompson",
      "email": "hunter@batcountry.com",
      "type": "anyone",
      "bank_account": {
        "id": "55afddde-4296-4daf-8e49-7ba481ef9608",
        "account_number": "13048322",
        "branch_code": "123456",
        "bank_name": "National Australia Bank",
        "state": "pending_verification",
        "iav_provider": null,
        "iav_status": null,
        "blocks": {
          "debits_blocked": false,
          "credits_blocked": false
        }
      },
      "links": {
        "add_bank_connection": "https://go.sandbox.split.cash/invite_contact/thomas-morgan-1/1030bfef-cef5-4938-b10b-5841cafafc80"
      }
    }
  ]
}
```

### Properties

*List all Contacts (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|[object]|true|No description|

## AddAnAnyoneContactRequest

<a id="schemaaddananyonecontactrequest"></a>

```json
{
  "name": "Hunter Thompson",
  "email": "hunter@batcountry.com",
  "branch_code": "123456",
  "account_number": "13048322",
  "metadata": {
    "custom_key": "Custom string",
    "another_custom_key": "Maybe a URL"
  }
}
```

### Properties

*Add a Contact (request)*

|Name|Type|Required|Description|
|---|---|---|---|
|name|string|true|The name of the Contact (140 max. characters)|
|email|string|true|The email of the Contact (256 max. characters)|
|branch_code|string|true|The bank account BSB of the Contact|
|account_number|string|true|The bank account number of the Contact|
|metadata|[Metadata](#schemametadata)|false|No description|

## AddAnAnyoneContactResponse

<a id="schemaaddananyonecontactresponse"></a>

```json
{
  "data": {
    "id": "6a7ed958-f1e8-42dc-8c02-3901d7057357",
    "name": "Hunter Thompson",
    "email": "hunter@batcountry.com",
    "type": "anyone",
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    },
    "bank_account": {
      "id": "55afddde-4296-4daf-8e49-7ba481ef9608",
      "account_number": "13048322",
      "branch_code": "123456",
      "bank_name": "National Australia Bank",
      "state": "active",
      "iav_provider": null,
      "iav_status": null,
      "blocks": {
        "debits_blocked": false,
        "credits_blocked": false
      }
    },
    "links": {
      "add_bank_connection": "https://go.sandbox.split.cash/invite_contact/thomas-morgan-1/1030bfef-cef5-4938-b10b-5841cafafc80"
    }
  }
}
```

### Properties

*Add a Contact (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|true|No description|

## GetABankConnectionResponse

<a id="schemagetabankconnectionresponse"></a>

```json
{
  "data": {
    "id": "c397645b-bd4f-4fc6-b1fe-4993fef6c3c7",
    "provider_name": "split",
    "state": "credentials_invalid",
    "refreshed_at": "2020-02-13T09:01:00Z",
    "removed_at": null,
    "failure_reason": null,
    "institution": {
      "short_name": "CBA",
      "full_name": "Commonwealth Bank of Australia"
    },
    "contact": {
      "id": "72e37667-6364-440f-b1bd-56df5654e258",
      "name": "Joel Boyle",
      "email": "travis@hermanntorp.net"
    },
    "links": {
      "update_bank_connection": "https://go.sandbox.split.cash/authorise_bank_connections/thomas-morgan-1/c397645b-bd4f-4fc6-b1fe-4993fef6c3c7"
    }
  }
}
```

### Properties

*Get a BankConnection (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|true|No description|

## GetAContactResponse

<a id="schemagetacontactresponse"></a>

```json
{
  "data": {
    "id": "55afddde-4296-4daf-8e49-7ba481ef9608",
    "ref": "CNT.123",
    "name": "Outstanding Tours Pty Ltd",
    "email": "accounts@outstandingtours.com.au",
    "type": "anyone",
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    },
    "bank_account": {
      "id": "fcabeacb-2ef6-4b27-ba19-4f6fa0d57dcb",
      "account_number": "947434694",
      "branch_code": "304304",
      "bank_name": "National Australia Bank",
      "state": "active",
      "iav_provider": null,
      "iav_status": null,
      "blocks": {
        "debits_blocked": false,
        "credits_blocked": false
      }
    },
    "anyone_account": {
      "id": "31a05f81-25a2-4085-92ef-0d16d0263bff"
    },
    "bank_connection": {
      "id": null
    },
    "links": {
      "add_bank_connection": "https://go.sandbox.split.cash/invite_contact/thomas-morgan-1/1030bfef-cef5-4938-b10b-5841cafafc80"
    },
    "payid_details": {
      "alias_value": "otp@pay.travel.com.au",
      "alias_type": "email",
      "alias_name": "your merchant's alias_name",
      "state": "active"
    }
  }
}
```

### Properties

*Get a Contact (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|true|No description|
|» id|string(uuid)|true|The Contact ID|
|» ref|string(string)|true|The Contact ref|
|» name|string|true|The Contact name (Min: 3 - Max: 140)|
|» email|string(email)|true|The Contact email (Min: 6 - Max: 256)|
|» type|string|true|(Deprecated) The Contact account type|
|» metadata|[Metadata](#schemametadata)|true|No description|
|» bank_account|object|true|No description|
|»» id|string(uuid)|false|The Bank Account ID|
|»» account_number|string|false|The Bank Account number (Min: 5 - Max: 9)|
|»» branch_code|string|false|The BSB number (Min: 6 - Max: 6)|
|»» state|string|false|The bank account state|
|»» iav_provider|string|false|The instant account verification provider|
|»» iav_status|string|false|The instant account verification bank connection status|
|»» blocks|object|false|No description|
|»»» debits_blocked|boolean|false|Used by Zepto admins. Defines whether the bank account is blocked from being debited|
|»»» credits_blocked|boolean|false|Used by Zepto admins. Defined Whether this bank account is blocked from being credited|
|»» anyone_account|object|true|No description|
|»»» id|string(uuid)|false|(Deprecated) The Anyone Account ID|
|»» bank_connection|object|false|No description|
|»»» id|string(uuid)|false|The bank connection ID|
|»» links|object|false|No description|
|»»» add_bank_connection|string(url)|false|A unique URL to share with the Contact in order to establish a new bank connection to their bank account|
|»» payid_details|object|false|No description|
|»»» alias_value|string(email)|false|The PayID email|
|»»» alias_type|string|false|Type of PayID. Fixed to `email`|
|»»» alias_name|string|false|Your merchant's alias_name|
|»»» state|string|false|Pending -> Active or Failed -> Deregistered (Contact removed)|

#### Enumerated Values

|Property|Value|
|---|---|
|type|Zepto account|
|type|anyone|
|state|active|
|state|removed|
|iav_provider|split|
|iav_provider|proviso|
|iav_provider|basiq|
|iav_provider|credit_sense|
|iav_status|active|
|iav_status|removed|
|iav_status|credentials_invalid|
|state|pending|
|state|active|
|state|failed|
|state|deregistered|

## UpdateAReceivableContactRequest

<a id="schemaupdateareceivablecontactrequest"></a>

```json
{
  "payid_name": "Bob Smith"
}
```

### Properties

*Update a Receivable Contact (request)*

|Name|Type|Required|Description|
|---|---|---|---|
|payid_name|string|true|The PayID name of the Receivable Contact|

## UpdateAContactRequest

<a id="schemaupdateacontactrequest"></a>

```json
{
  "name": "My very own alias",
  "email": "updated@email.com",
  "branch_code": "123456",
  "account_number": "99887766",
  "metadata": {
    "custom_key": "Custom string",
    "another_custom_key": "Maybe a URL"
  }
}
```

### Properties

*Update a Contact (request)*

|Name|Type|Required|Description|
|---|---|---|---|
|name|string|false|The name of the Contact|
|email|string|false|The email of the Contact|
|branch_code|string|false|The bank account BSB of the Contact|
|account_number|string|false|The bank account number of the Contact|
|metadata|[Metadata](#schemametadata)|false|No description|

## UpdateAContactResponse

<a id="schemaupdateacontactresponse"></a>

```json
{
  "data": {
    "id": "fcabeacb-2ef6-4b27-ba19-4f6fa0d57dcb",
    "name": "My very own alias",
    "email": "updated@email.com",
    "type": "anyone",
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    },
    "bank_account": {
      "id": "55afddde-4296-4daf-8e49-7ba481ef9608",
      "account_number": "99887766",
      "branch_code": "123456",
      "bank_name": "Zepto SANDBOX Bank",
      "state": "active",
      "iav_provider": null,
      "iav_status": null,
      "blocks": {
        "debits_blocked": false,
        "credits_blocked": false
      }
    },
    "anyone_account": {
      "id": "63232c0a-a783-4ae9-ae73-f0974fe1e345"
    },
    "links": {
      "add_bank_connection": "http://go.sandbox.split.cash/invite_contact/dog-bones-inc/fcabeacb-2ef6-4b27-ba19-4f6fa0d57dcb"
    }
  }
}
```

### Properties

*Update a Contact (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|true|No description|

## MakeAPaymentRequest

<a id="schemamakeapaymentrequest"></a>

```json
{
  "description": "The SuperPackage",
  "matures_at": "2021-06-13T00:00:00Z",
  "your_bank_account_id": "83623359-e86e-440c-9780-432a3bc3626f",
  "channels": [
    "new_payments_platform"
  ],
  "payouts": [
    {
      "amount": 30000,
      "description": "A tandem skydive jump SB23094",
      "recipient_contact_id": "48b89364-1577-4c81-ba02-96705895d457",
      "metadata": {
        "invoice_ref": "BILL-0001",
        "invoice_id": "c80a9958-e805-47c0-ac2a-c947d7fd778d",
        "custom_key": "Custom string",
        "another_custom_key": "Maybe a URL"
      }
    }
  ],
  "metadata": {
    "custom_key": "Custom string",
    "another_custom_key": "Maybe a URL"
  }
}
```

### Properties

*Make a Payment (request)*

|Name|Type|Required|Description|
|---|---|---|---|
|description|string|true|User description. Only visible to the payer|
|matures_at|string(date-time)|true|Date & time in UTC ISO8601 the Payment should be processed. (Can not be earlier than the start of current day in Sydney AEST/AEDT)|
|your_bank_account_id|string|true|Specify where we should take the funds for this transaction. If omitted, your primary bank account will be used.|
|channels|array|true|Specify the payment channel to be used, in order. (new_payments_platform, direct_entry, or both)|
|payouts|[[Payout](#schemapayout)]|true|One Payout object only|
|metadata|[Metadata](#schemametadata)|false|No description|

## Payout

<a id="schemapayout"></a>

```json
{
  "amount": 30000,
  "description": "A tandem skydive jump SB23094",
  "recipient_contact_id": "48b89364-1577-4c81-ba02-96705895d457",
  "metadata": null
}
```

### Properties

*Payout*

|Name|Type|Required|Description|
|---|---|---|---|
|amount|integer|true|Amount in cents to pay the recipient|
|description|string|true|Description that both the payer and recipient can see. For Direct Entry payments, the payout recipient will see the first 9 characters of this description. For NPP payments, the payout recipient will see the first 280 characters of this description.|
|recipient_contact_id|string|true|Contact to pay (`Contact.data.id`)|
|metadata|Metadata|false|Use for your custom data and certain Zepto customisations. Stored against generated transactions and included in associated webhook payloads.|

## VoidAPayoutRequest

<a id="schemavoidapayoutrequest"></a>

```json
{
  "details": "Incorrect recipient"
}
```

### Properties

*Void a Payout (request)*

|Name|Type|Required|Description|
|---|---|---|---|
|details|string|false|Optional details about why the payout has been voided|

## Metadata

<a id="schemametadata"></a>

```json
{
  "custom_key": "Custom string",
  "another_custom_key": "Maybe a URL"
}
```

### Properties

*Metadata*

*None*

## MakeAPaymentResponse

<a id="schemamakeapaymentresponse"></a>

```json
{
  "data": {
    "ref": "PB.1",
    "your_bank_account_id": "83623359-e86e-440c-9780-432a3bc3626f",
    "channels": [
      "new_payments_platform"
    ],
    "payouts": [
      {
        "ref": "D.1",
        "recipient_contact_id": "48b89364-1577-4c81-ba02-96705895d457",
        "batch_description": "The SuperPackage",
        "matures_at": "2016-09-13T23:50:44Z",
        "created_at": "2016-09-10T23:50:44Z",
        "status": "maturing",
        "amount": 30000,
        "description": "A tandem skydive jump SB23094",
        "from_id": "83623359-e86e-440c-9780-432a3bc3626f",
        "to_id": "21066764-c103-4e7f-b436-4cee7db5f400",
        "metadata": {
          "invoice_ref": "BILL-0001",
          "invoice_id": "c80a9958-e805-47c0-ac2a-c947d7fd778d",
          "custom_key": "Custom string",
          "another_custom_key": "Maybe a URL"
        }
      }
    ],
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    }
  }
}
```

### Properties

*Make a Payment (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|true|No description|

## ListAllPaymentsResponse

<a id="schemalistallpaymentsresponse"></a>

```json
{
  "data": [
    {
      "ref": "PB.1",
      "your_bank_account_id": "83623359-e86e-440c-9780-432a3bc3626f",
      "channels": [
        "new_payments_platform",
        "direct_entry"
      ],
      "payouts": [
        {
          "ref": "D.1",
          "recipient_contact_id": "48b89364-1577-4c81-ba02-96705895d457",
          "batch_description": "This description is only available to the payer",
          "matures_at": "2016-09-13T23:50:44Z",
          "created_at": "2016-09-10T23:50:44Z",
          "status": "maturing",
          "amount": 30000,
          "description": "The recipient will see this description",
          "from_id": "83623359-e86e-440c-9780-432a3bc3626f",
          "to_id": "21066764-c103-4e7f-b436-4cee7db5f400",
          "metadata": {
            "invoice_ref": "BILL-0001",
            "invoice_id": "c80a9958-e805-47c0-ac2a-c947d7fd778d",
            "custom_key": "Custom string",
            "another_custom_key": "Maybe a URL"
          }
        },
        {
          "ref": "D.2",
          "recipient_contact_id": "dc6f1e60-3803-43ca-a200-7d641816f57f",
          "batch_description": "This description is only available to the payer",
          "matures_at": "2016-09-13T23:50:44Z",
          "created_at": "2016-09-10T23:50:44Z",
          "status": "maturing",
          "amount": 30000,
          "description": "The recipient will see this description",
          "from_id": "48b89364-1577-4c81-ba02-96705895d457",
          "to_id": "f989d9cd-87fc-4c73-b0a4-1eb0e8768d3b"
        }
      ],
      "metadata": {
        "custom_key": "Custom string",
        "another_custom_key": "Maybe a URL"
      }
    }
  ]
}
```

### Properties

*List all Payments (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|[object]|true|No description|

## GetAPaymentResponse

<a id="schemagetapaymentresponse"></a>

```json
{
  "data": {
    "ref": "PB.1",
    "your_bank_account_id": "83623359-e86e-440c-9780-432a3bc3626f",
    "channels": [
      "direct_entry"
    ],
    "payouts": [
      {
        "ref": "D.1",
        "recipient_contact_id": "48b89364-1577-4c81-ba02-96705895d457",
        "batch_description": "The SuperPackage",
        "matures_at": "2016-09-13T23:50:44Z",
        "created_at": "2016-09-10T23:50:44",
        "status": "maturing",
        "amount": 30000,
        "description": "A tandem skydive jump SB23094",
        "from_id": "83623359-e86e-440c-9780-432a3bc3626f",
        "to_id": "21066764-c103-4e7f-b436-4cee7db5f400",
        "metadata": {
          "invoice_ref": "BILL-0001",
          "invoice_id": "c80a9958-e805-47c0-ac2a-c947d7fd778d",
          "custom_key": "Custom string",
          "another_custom_key": "Maybe a URL"
        }
      }
    ],
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    }
  }
}
```

### Properties

*Get a Payment (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|true|No description|

## MakeAPaymentRequestRequest

<a id="schemamakeapaymentrequestrequest"></a>

```json
{
  "description": "Visible to both initiator and authoriser",
  "matures_at": "2016-12-19T02:10:56.000Z",
  "amount": 99000,
  "authoriser_contact_id": "de86472c-c027-4735-a6a7-234366a27fc7",
  "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
  "metadata": {
    "custom_key": "Custom string",
    "another_custom_key": "Maybe a URL"
  }
}
```

### Properties

*Make a Payment Request (request)*

|Name|Type|Required|Description|
|---|---|---|---|
|description|string|true|Description visible to the initiator (payee). The first 9 characters supplied will be visible to the authoriser (payer)|
|matures_at|string(date-time)|true|Date & time in UTC ISO8601 that the Payment will be processed if the request is approved. (If the request is approved after this point in time, it will be processed straight away)|
|amount|integer|true|Amount in cents to pay the initiator (Min: 1 - Max: 99999999999)|
|authoriser_contact_id|string|true|The Contact the payment will be requested from (`Contact.data.id`)|
|your_bank_account_id|string(uuid)|false|Specify where we should settle the funds for this transaction. If omitted, your primary bank account will be used.|
|metadata|object|false|Use for your custom data and certain Zepto customisations. Stored against generated transactions and included in associated webhook payloads.|

## MakeAPaymentRequestResponse

<a id="schemamakeapaymentrequestresponse"></a>

```json
{
  "data": {
    "ref": "PR.39p1",
    "initiator_id": "ca7bc5b3-e47f-4153-96fb-bbe326b42772",
    "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
    "authoriser_id": "970e4526-67d9-4ed9-b554-f5cf390ab775",
    "authoriser_contact_id": "de86472c-c027-4735-a6a7-234366a27fc7",
    "contact_initiated": false,
    "schedule_ref": null,
    "status": "pending_approval",
    "status_reason": null,
    "matures_at": "2021-12-25T00:00:00Z",
    "responded_at": null,
    "created_at": "2021-12-19T02:10:56Z",
    "credit_ref": null,
    "payout": {
      "amount": 99000,
      "description": "Premium Package for 4",
      "matures_at": "2021-12-25T00:00:00Z"
    },
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    }
  }
}
```

### Properties

*Make a Payment Request (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|true|No description|
|» ref|string|true|The Payment Request reference (PR.*) (Min: 4 - Max: 8)|
|» initiator_id|string(uuid)|true|Your bank account ID where the funds will settle (Min: 36 - Max: 36)|
|» your_bank_account_id|string(uuid)|true|Your bank account ID where the funds will settle (alias of `initiator_id`) (Min: 36 - Max: 36)|
|» authoriser_id|string(uuid)|true|The debtor's bank account ID (Min: 36 - Max: 36)|
|» authoriser_contact_id|string(uuid)|true|The contact ID representing the debtor within Zepto (Min: 36 - Max: 36)|
|» contact_initiated|boolean|true|Initiated by Contact or Merchant|
|» schedule_ref|string|true|The schedule that generated the Payment request if applicable (Min: 0 - Max: 8)|
|» status|string|true|The status of the Payment Request|
|» status_reason|string|true|Only used when the `status` is `declined` due to prechecking. (Min: 0 - Max: 280)|
|» matures_at|string(date-time)|true|The date-time when the Payment Request is up for processing (Min: 20 - Max: 20)|
|» responded_at|string(date-time)|true|The date-time when the Payment Request status changed (Min: 0 - Max: 20)|
|» created_at|string(date-time)|true|The date-time when the Payment Request was created (Min: 20 - Max: 20)|
|» credit_ref|string|true|The resulting credit entry reference (available once approved) (Min: 4 - Max: 8)|
|» payout|object|true|No description|
|»» amount|integer|true|Amount in cents (Min: 1 - Max: 99999999999)|
|»» description|string|true|Payment Request description (Min: 1 - Max: 280)|
|»» matures_at|string(date-time)|true|The date-time when the Payment Request is up for processing (Min: 20 - Max: 20)|
|» metadata|object|false|Your custom keyed data|

#### Enumerated Values

|Property|Value|
|---|---|
|status|pending_approval|
|status|unverified|
|status|approved|
|status|declined|
|status|cancelled|
|status_reason|The balance of the nominated bank account for this Payment Request is not available.|
|status_reason|The nominated bank account for this Payment Request has insufficient funds.|

## MakeAPaymentRequestWithNoAgreementResponse

<a id="schemamakeapaymentrequestwithnoagreementresponse"></a>

```json
{
  "errors": "Authoriser contact (de86472c-c027-4735-a6a7-234366a27fc7) is not a Zepto account holder and therefore must have a valid agreement in place before a Payment Request can be issued."
}
```

### Properties

*Make a Payment Request to an Anyone Contact with no valid Agreement (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|errors|string|true|No description|

## GetAPaymentRequestResponse

<a id="schemagetapaymentrequestresponse"></a>

```json
{
  "data": {
    "ref": "PR.88me",
    "initiator_id": "ca7bc5b3-e47f-4153-96fb-bbe326b42772",
    "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
    "authoriser_id": "970e4526-67d9-4ed9-b554-f5cf390ab775",
    "authoriser_contact_id": "de86472c-c027-4735-a6a7-234366a27fc7",
    "contact_initiated": false,
    "schedule_ref": null,
    "status": "approved",
    "status_reason": null,
    "matures_at": "2021-11-25T00:00:00Z",
    "responded_at": "2021-11-19T02:38:04Z",
    "created_at": "2021-11-19T02:10:56Z",
    "credit_ref": "C.b6tf",
    "payout": {
      "amount": 1200,
      "description": "Xbox Live subscription",
      "matures_at": "2021-11-25T00:00:00Z"
    },
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    }
  }
}
```

### Properties

*Get a Payment Request (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|true|No description|
|» ref|string|true|The Payment Request reference (PR.*) (Min: 4 - Max: 8)|
|» initiator_id|string(uuid)|true|Your bank account ID where the funds will settle (Min: 36 - Max: 36)|
|» your_bank_account_id|string(uuid)|true|Your bank account ID where the funds will settle (alias of `initiator_id`) (Min: 36 - Max: 36)|
|» authoriser_id|string(uuid)|true|The debtor's bank account ID (Min: 36 - Max: 36)|
|» authoriser_contact_id|string(uuid)|true|The contact ID representing the debtor within Zepto (Min: 36 - Max: 36)|
|» schedule_ref|string|true|The schedule that generated the Payment request if applicable (Min: 0 - Max: 8)|
|» status|string|true|The status of the Payment Request|
|» status_reason|string|true|Only used when the `status` is `declined` due to prechecking. (Min: 0 - Max: 280)|
|» matures_at|string(date-time)|true|The date-time when the Payment Request is up for processing (Min: 20 - Max: 20)|
|» responded_at|string(date-time)|true|The date-time when the Payment Request status changed (Min: 0 - Max: 20)|
|» created_at|string(date-time)|true|The date-time when the Payment Request was created (Min: 20 - Max: 20)|
|» credit_ref|string|false|The resulting credit entry reference (available once approved) (Min: 4 - Max: 8)|
|» payout|object|true|No description|
|»» amount|integer|true|Amount in cents (Min: 1 - Max: 99999999999)|
|»» description|string|true|Payment Request description (Min: 1 - Max: 280)|
|»» matures_at|string(date-time)|true|The date-time when the Payment Request is up for processing (Min: 20 - Max: 20)|
|» metadata|object|false|Your custom keyed data|

#### Enumerated Values

|Property|Value|
|---|---|
|status|pending_approval|
|status|unverified|
|status|approved|
|status|declined|
|status|cancelled|
|status_reason|The balance of the nominated bank account for this Payment Request is not available.|
|status_reason|The nominated bank account for this Payment Request has insufficient funds.|

## ListPaymentRequestCollectionsResponse

<a id="schemalistpaymentrequestcollectionsresponse"></a>

```json
{
  "data": [
    {
      "ref": "PR.84t6",
      "initiator_id": "ca7bc5b3-e47f-4153-96fb-bbe326b42772",
      "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
      "authoriser_id": "de86472c-c027-4735-a6a7-234366a27fc7",
      "authoriser_contact_id": "fb6a9252-3818-44dc-b5aa-2195391a746f",
      "contact_initiated": false,
      "schedule_ref": "PRS.89t3",
      "status": "approved",
      "status_reason": null,
      "matures_at": "2021-07-18T02:10:00Z",
      "responded_at": "2021-07-18T02:10:00Z",
      "created_at": "2021-07-18T02:10:00Z",
      "credit_ref": "C.6gr7",
      "payout": {
        "amount": 4999,
        "description": "Subscription Payment",
        "matures_at": "2021-07-18T02:10:00Z"
      }
    },
    {
      "ref": "PR.45h7",
      "initiator_id": "ca7bc5b3-e47f-4153-96fb-bbe326b42772",
      "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
      "authoriser_id": "de86472c-c027-4735-a6a7-234366a27fc7",
      "authoriser_contact_id": "fb6a9252-3818-44dc-b5aa-2195391a746f",
      "contact_initiated": false,
      "schedule_ref": null,
      "status": "pending_approval",
      "status_reason": null,
      "matures_at": "2021-03-09T16:58:00Z",
      "responded_at": null,
      "created_at": "2021-03-09T16:58:00Z",
      "credit_ref": null,
      "payout": {
        "amount": 3000,
        "description": "Membership fees",
        "matures_at": "2021-03-09T16:58:00Z"
      }
    }
  ]
}
```

### Properties

*List Collections (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|[object]|true|No description|
|» ref|string|true|The Payment Reference reference (PR.*)|
|» initiator_id|string(uuid)|true|Your bank account ID where the funds will settle|
|» your_bank_account_id|string(uuid)|true|Your bank account ID where the funds will settle (alias of `initiator_id`)|
|» authoriser_id|string(uuid)|true|The debtor's bank account ID|
|» authoriser_contact_id|string(uuid)|true|The contact ID representing the debtor within Zepto|
|» contact_initiated|boolean|true|Initiated by Contact or Merchant|
|» schedule_ref|string|true|The schedule that generated the Payment request if applicable|
|» status|string|true|The status of the Payment Request|
|» status_reason|string|true|Only used when the `status` is `declined` due to prechecking.|
|» matures_at|string(date-time)|true|The date-time when the Payment Request is up for processing|
|» responded_at|string(date-time)|true|The date-time when the Payment Request status changed|
|» created_at|string(date-time)|true|The date-time when the Payment Request was created|
|» credit_ref|string|true|The resulting credit entry reference (available once approved)|
|» payout|object|true|No description|
|»» amount|integer|true|Amount in cents (Min: 1 - Max: 99999999999)|
|»» description|string|true|Payment Request description|
|»» matures_at|string(date-time)|true|The date-time when the Payment Request is up for processing|
|» metadata|[object]|false|Your custom keyed data|

#### Enumerated Values

|Property|Value|
|---|---|
|status|pending_approval|
|status|unverified|
|status|approved|
|status|declined|
|status|cancelled|
|status_reason|The balance of the nominated bank account for this Payment Request is not available.|
|status_reason|The nominated bank account for this Payment Request has insufficient funds.|

## ListPaymentRequestReceivablesResponse

<a id="schemalistpaymentrequestreceivablesresponse"></a>

```json
{
  "data": [
    {
      "ref": "PR.2t65",
      "initiator_id": "ca7bc5b3-e47f-4153-96fb-bbe326b42772",
      "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
      "authoriser_id": "de86472c-c027-4735-a6a7-234366a27fc7",
      "authoriser_contact_id": "fb6a9252-3818-44dc-b5aa-2195391a746f",
      "contact_initiated": true,
      "schedule_ref": null,
      "status": "approved",
      "status_reason": null,
      "matures_at": "2021-05-12T13:43:12Z",
      "responded_at": "2021-05-12T13:43:12Z",
      "created_at": "2021-05-12T13:43:12Z",
      "credit_ref": "C.77b1",
      "payout": {
        "amount": 50000,
        "description": "Deposit to my Trading account",
        "matures_at": "2021-05-12T13:43:12Z"
      }
    },
    {
      "ref": "PR.1n644",
      "initiator_id": "ca7bc5b3-e47f-4153-96fb-bbe326b42772",
      "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
      "authoriser_id": "de86472c-c027-4735-a6a7-234366a27fc7",
      "authoriser_contact_id": "fb6a9252-3818-44dc-b5aa-2195391a746f",
      "contact_initiated": true,
      "schedule_ref": null,
      "status": "approved",
      "status_reason": null,
      "matures_at": "2021-06-01T04:34:50Z",
      "responded_at": null,
      "created_at": "2021-06-01T04:34:56Z",
      "credit_ref": "c.54r3",
      "payout": {
        "amount": 5000,
        "description": "Punting account top-up",
        "matures_at": "2021-06-01T04:34:56Z"
      }
    }
  ]
}
```

### Properties

*List Receivables (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|[object]|true|No description|
|» ref|string|true|The Payment Reference reference (PR.*)|
|» initiator_id|string(uuid)|true|Your bank account ID where the funds will settle|
|» your_bank_account_id|string(uuid)|true|Your bank account ID where the funds will settle (alias of `initiator_id`)|
|» authoriser_id|string(uuid)|true|The debtor's bank account ID|
|» authoriser_contact_id|string(uuid)|true|The contact ID representing the debtor within Zepto|
|» contact_initiated|boolean|true|Initiated by Contact or Merchant|
|» schedule_ref|string|true|The schedule that generated the Payment request if applicable|
|» status|string|true|The status of the Payment Request. For Receivables, this will always be *approved*|
|» status_reason|string|true|Only used when the `status` is `declined` due to prechecking.|
|» matures_at|string(date-time)|true|The date-time when the Payment Request is up for processing|
|» responded_at|string(date-time)|true|The date-time when the Payment Request status changed|
|» created_at|string(date-time)|true|The date-time when the Payment Request was created|
|» credit_ref|string|true|The resulting credit entry reference (available once approved)|
|» payout|object|true|No description|
|»» amount|integer|true|Amount in cents (Min: 1 - Max: 99999999999)|
|»» description|string|true|Payment Request description|
|»» matures_at|string(date-time)|true|The date-time when the Payment Request is up for processing|
|» metadata|[object]|false|Your custom keyed data|

## IssueARefundRequest

<a id="schemaissuearefundrequest"></a>

```json
{
  "amount": 500,
  "channels": [
    "direct_entry"
  ],
  "reason": "Because reason",
  "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
  "metadata": {
    "custom_key": "Custom string",
    "another_custom_key": "Maybe a URL"
  }
}
```

### Properties

*Issue a Refund (request)*

|Name|Type|Required|Description|
|---|---|---|---|
|amount|integer|true|Amount in cents refund (Min: 1 - Max: 99999999999)|
|channels|array|false|Specify the payment channel to be used, in order. (new_payments_platform, direct_entry, or both)|
|reason|string|false|Reason for the refund. First 9 characters are visible to both parties.|
|your_bank_account_id|string(uuid)|false|Specify where we should take the funds for this transaction. If omitted, your primary bank account will be used.|
|metadata|[Metadata](#schemametadata)|false|No description|

## IssueARefundResponse

<a id="schemaissuearefundresponse"></a>

```json
{
  "data": {
    "ref": "PRF.7f4",
    "for_ref": "C.1gf22",
    "debit_ref": "D.63hgf",
    "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
    "created_at": "2021-06-01T07:20:24Z",
    "amount": 500,
    "channels": [
      "direct_entry"
    ],
    "reason": "Subscription refund",
    "contacts": {
      "source_contact_id": "194b0237-6c2c-4705-b4fb-308274b14eda",
      "target_contact_id": "3694ff53-32ea-40ae-8392-821e48d7bd5a"
    },
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    }
  }
}
```

### Properties

*Issue a Refund (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|true|No description|
|» ref|string(uuid)|true|The Refund request reference (PRF.*) (Min: 5 - Max: 9)|
|» for_ref|string|true|The associated credit reference (C.*)|
|» debit_ref|string|true|The associated debit reference (C.*)|
|» your_bank_account_id|string|true|The source bank/float account (UUID)|
|» created_at|string(date-time)|true|The date-time when the Payment Request was created|
|» amount|integer|true|The amount value provided (Min: 1 - Max: 99999999999)|
|» channels|array|false|The requested payment channel(s) to be used, in order. (new_payments_platform, direct_entry, or both)|
|» reason|string|true|Reason for the refund|
|» contacts|object|false|No description|
|»» source_contact_id|string|false|The original 'Receivable Contact' ID (only visible when refunding Receivables)|
|»» target_contact_id|string|false|The new Contact ID receiving the funds (only visible when refunding Receivables)|

## ListOutgoingRefundsResponse

<a id="schemalistoutgoingrefundsresponse"></a>

```json
{
  "data": [
    {
      "ref": "PRF.2",
      "for_ref": "C.5",
      "debit_ref": "D.5a",
      "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
      "created_at": "2017-05-09T04:45:26Z",
      "amount": 5,
      "reason": "Because reason",
      "metadata": {
        "custom_key": "Custom string",
        "another_custom_key": "Maybe a URL"
      }
    }
  ]
}
```

### Properties

*List outgoing Refunds (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|[object]|true|No description|

## RetrieveARefundResponse

<a id="schemaretrievearefundresponse"></a>

```json
{
  "data": {
    "ref": "PRF.1",
    "for_ref": "C.59",
    "debit_ref": "D.hi",
    "your_bank_account_id": "9c70871d-8e36-4c3e-8a9c-c0ee20e7c679",
    "created_at": "2017-05-08T07:20:24Z",
    "amount": 500,
    "reason": "Because reason",
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    }
  }
}
```

### Properties

*Retrieve a Refund (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|true|No description|

## RetryPayoutResponse

<a id="schemaretrypayoutresponse"></a>

```json
{
  "data": {
    "ref": "C.2",
    "parent_ref": "PR.039a",
    "type": "credit",
    "category": "payout",
    "created_at": "2016-12-05T23:15:00Z",
    "matures_at": "2016-12-06T23:15:00Z",
    "cleared_at": null,
    "bank_ref": null,
    "status": "maturing",
    "status_changed_at": "2016-12-05T23:15:00Z",
    "party_contact_id": "33c6e31d3-1dc1-448b-9512-0320bc44fdcf",
    "party_name": "Price and Sons",
    "party_nickname": "price-and-sons-2",
    "party_bank_ref": null,
    "description": "Money for jam",
    "amount": 1
  }
}
```

### Properties

*Retry a payout (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|[object]|true|No description|

## ListAllTransactionsResponse

<a id="schemalistalltransactionsresponse"></a>

```json
{
  "data": [
    {
      "ref": "D.3",
      "parent_ref": null,
      "type": "debit",
      "category": "payout_refund",
      "created_at": "2021-04-07T23:15:00Z",
      "matures_at": "2021-04-07T23:15:00Z",
      "cleared_at": "2021-04-10T23:15:00Z",
      "bank_ref": "DT.9a",
      "status": "cleared",
      "status_changed_at": "2021-04-10T23:15:00Z",
      "party_contact_id": "31354923-b1e9-4d65-b03c-415ead89cbf3",
      "party_name": "Sanford-Rees",
      "party_nickname": null,
      "party_bank_ref": "CT.11",
      "description": null,
      "amount": 20000,
      "bank_account_id": "56df206a-aaff-471a-b075-11882bc8906a",
      "channels": [
        "float account"
      ],
      "current_channel": "float account"
    },
    {
      "ref": "D.2",
      "parent_ref": "PB.2",
      "type": "debit",
      "category": "payout",
      "created_at": "2016-12-06T23:15:00Z",
      "matures_at": "2016-12-09T23:15:00Z",
      "cleared_at": null,
      "bank_ref": null,
      "status": "maturing",
      "status_changed_at": "2016-12-06T23:15:00Z",
      "party_contact_id": "3c6e31d3-1dc1-448b-9512-0320bc44fdcf",
      "party_name": "Gutmann-Schmidt",
      "party_nickname": null,
      "party_bank_ref": null,
      "description": "Batteries for hire",
      "amount": 2949299,
      "bank_account_id": "56df206a-aaff-471a-b075-11882bc8906a",
      "channels": [
        "float_account"
      ],
      "current_channel": "float_account"
    },
    {
      "ref": "C.2",
      "parent_ref": "PB.s0z",
      "type": "credit",
      "category": "payout",
      "created_at": "2016-12-05T23:15:00Z",
      "matures_at": "2016-12-06T23:15:00Z",
      "cleared_at": "2016-12-09T23:15:00Z",
      "bank_ref": "CT.1",
      "status": "cleared",
      "status_changed_at": "2016-12-09T23:15:00Z",
      "party_contact_id": "33c6e31d3-1dc1-448b-9512-0320bc44fdcf",
      "party_name": "Price and Sons",
      "party_nickname": "price-and-sons-2",
      "party_bank_ref": null,
      "description": "Online purchase",
      "amount": 19999,
      "bank_account_id": "c2e329ae-606f-4311-a9ab-a751baa1915c",
      "channels": [
        "new_payments_platform",
        "direct_entry"
      ],
      "current_channel": "direct_entry",
      "metadata": {
        "customer_id": "xur4492",
        "product_ref": "TSXL392110x"
      }
    }
  ]
}
```

### Properties

*List all transactions (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|[[TransactionResponse](#schematransactionresponse)]|true|No description|

## TransactionResponse

<a id="schematransactionresponse"></a>

```json
{
  "ref": "C.2",
  "parent_ref": "PB.s0z",
  "type": "credit",
  "category": "payout",
  "created_at": "2016-12-05T23:15:00Z",
  "matures_at": "2016-12-06T23:15:00Z",
  "cleared_at": "2016-12-09T23:15:00Z",
  "bank_ref": "CT.1",
  "status": "cleared",
  "status_changed_at": "2016-12-09T23:15:00Z",
  "party_contact_id": "33c6e31d3-1dc1-448b-9512-0320bc44fdcf",
  "party_name": "Price and Sons",
  "party_nickname": "price-and-sons-2",
  "party_bank_ref": null,
  "description": "Online purchase",
  "amount": 19999,
  "bank_account_id": "c2e329ae-606f-4311-a9ab-a751baa1915c",
  "channels": [
    "direct_entry"
  ],
  "current_channel": "direct_entry",
  "metadata": {
    "customer_id": "xur4492",
    "product_ref": "TSXL392110x"
  }
}
```

### Properties

*A transaction (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|ref|string|true|The ref of the transaction (`C.*` or `D.*`)|
|parent_ref|string|true|The ref of the parent of this transaction|
|type|string|true|The type of the transaction|
|category|string|true|The category of the transaction|
|created_at|string(date-time)|true|When the transaction was created|
|matures_at|string(date-time)|false|When the transaction was processed|
|cleared_at|string(date-time)|true|When the transaction was cleared|
|bank_ref|string|true|The ref that is sent to the bank|
|status|string|true|The status of the transaction (see [Transactions/Lifecycle](#lifecycle-4) for more info)|
|status_changed_at|string|true|When the status was last changed|
|failure_details|string|false|Details if a failure occured|
|failure|[Failure](#schemafailure)|false|No description|
|party_contact_id|string(uuid)|true|The transaction party's contact ID|
|party_name|string|true|The transaction party's name|
|party_nickname|string|true|The transaction party's nickname|
|party_bank_ref|string|true|The transaction party's bank ref|
|description|string|true|The transaction's description|
|amount|integer|true|Amount in cents (Min: 1 - Max: 99999999999)|
|bank_account_id|string(uuid)|true|The bank account ID of this transaction|
|channels|array|true|Which payment channels this transaction can use (see [Payments/Make a payment](#make-a-payment) for more info)|
|current_channel|string|true|The current payment channel in use for this transaction|
|reversal_details|object|false|Reversal details (see [Payments/Lifecyle](#lifecycle-3) for more info)|
|» source_debit_ref|string|false|The source debit ref of the reversal|
|» source_credit_failure|[Failure](#schemafailure)|false|No description|
|metadata|[Metadata](#schemametadata)|false|No description|

#### Enumerated Values

|Property|Value|
|---|---|
|type|credit|
|type|debit|
|category|payout|
|category|payout_refund|
|category|invoice|
|category|payout_reversal|
|category|transfer|
|category|recovery|
|status|maturing|
|status|matured|
|status|preprecessing|
|status|processing|
|status|clearing|
|status|cleared|
|status|rejected|
|status|returned|
|status|voided|
|status|pending_verification|
|status|paused|
|status|prefailed|
|status|channel_switched|
|current_channel|direct_entry|
|current_channel|float_account|
|current_channel|new_payments_platform|

## Failure

<a id="schemafailure"></a>

```json
{
  "code": "E205",
  "title": "Account Not Found",
  "detail": "The target account number cannot be found by the financial institution."
}
```

### Properties

*Failure object (see [Transaction/Failure codes](#failure-codes) for more info)*

|Name|Type|Required|Description|
|---|---|---|---|
|code|string|true|No description|
|title|string|true|No description|
|detail|string|true|No description|

## ProposeUnassignedAgreementRequest

<a id="schemaproposeunassignedagreementrequest"></a>

```json
{
  "expiry_in_seconds": 60,
  "single_use": false,
  "terms": {
    "per_payout": {
      "min_amount": null,
      "max_amount": 10000
    },
    "per_frequency": {
      "days": 7,
      "max_amount": 1000000
    }
  },
  "metadata": {
    "custom_key": "Custom string",
    "another_custom_key": "Maybe a URL"
  }
}
```

### Properties

*Propose an Unassigned Agreement (request)*

|Name|Type|Required|Description|
|---|---|---|---|
|expiry_in_seconds|integer|true|The amount of time in seconds before the Unassigned Agreement can no longer be accepted.|
|single_use|boolean|false|Optionally propose a single use agreement. When the Unassigned Agreement is accepted and a Payment Request is approved according to the Agreement terms, the agreement will automatically become <code>expended</code>.<br><br>The proposed agreement must have equal max/min <code>per_payout</code> amounts and <code>null</code> <code>per_frequency</code> amounts.<br><br>Furthermore, we will automatically check that the authoriser's bank account has sufficient funds to honour the agreement terms.|
|terms|[Terms](#schematerms)|true|No description|
|metadata|[Metadata](#schemametadata)|false|No description|

## ProposeUnassignedAgreementResponse

<a id="schemaproposeunassignedagreementresponse"></a>

```json
{
  "data": {
    "ref": "A.4k",
    "initiator_id": "4e2728cc-b4ba-42c2-a6c3-26a7758de58d",
    "status": "proposed",
    "responded_at": null,
    "created_at": "2017-03-20T00:53:27Z",
    "terms": {
      "per_payout": {
        "max_amount": 10000,
        "min_amount": null
      },
      "per_frequency": {
        "days": 7,
        "max_amount": 1000000
      }
    },
    "assignment_expires_at": "2017-03-20T00:54:27Z",
    "link": "https://go.sandbox.split.cash/unassigned_agreements/b61fc159-8779-4a17-a826-e398e3e7e211/invitation",
    "metadata": {
      "custom_key": "Custom string",
      "another_custom_key": "Maybe a URL"
    }
  }
}
```

### Properties

*Propose an Unassigned Agreement (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|true|No description|

## ListUnassignedAgreementsResponse

<a id="schemalistunassignedagreementsresponse"></a>

```json
{
  "data": [
    {
      "ref": "A.4k",
      "initiator_id": "4e2728cc-b4ba-42c2-a6c3-26a7758de58d",
      "status": "proposed",
      "responded_at": null,
      "created_at": "2017-03-20T00:53:27Z",
      "terms": {
        "per_payout": {
          "max_amount": 10000,
          "min_amount": null
        },
        "per_frequency": {
          "days": 7,
          "max_amount": 1000000
        }
      },
      "assignment_expires_at": "2017-03-20T00:54:27Z",
      "link": "https://go.sandbox.split.cash/unassigned_agreements/b61fc159-8779-4a17-a826-e398e3e7e211/invitation"
    },
    {
      "ref": "A.7ea",
      "initiator_id": "b61fc159-8779-4a17-a826-e398e3e7e211",
      "status": "proposed",
      "responded_at": null,
      "created_at": "2017-03-21T00:53:27Z",
      "terms": {
        "per_payout": {
          "max_amount": null,
          "min_amount": null
        },
        "per_frequency": {
          "days": null,
          "max_amount": null
        }
      },
      "assignment_expires_at": "2017-03-21T00:54:27Z",
      "link": "https://go.sandbox.split.cash/unassigned_agreements/4e2728cc-b4ba-42c2-a6c3-26a7758de58d/invitation"
    }
  ]
}
```

### Properties

*List Unassigned Agreements (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|[object]|true|No description|

## GetUnassignedAgreementResponse

<a id="schemagetunassignedagreementresponse"></a>

```json
{
  "data": {
    "ref": "A.4k",
    "initiator_id": "4e2728cc-b4ba-42c2-a6c3-26a7758de58d",
    "status": "proposed",
    "responded_at": null,
    "created_at": "2017-03-20T00:53:27Z",
    "terms": {
      "per_payout": {
        "max_amount": 10000,
        "min_amount": null
      },
      "per_frequency": {
        "days": 7,
        "max_amount": 1000000
      }
    },
    "assignment_expires_at": "2017-03-20T00:54:27Z",
    "link": "https://go.sandbox.split.cash/unassigned_agreements/b61fc159-8779-4a17-a826-e398e3e7e211/invitation"
  }
}
```

### Properties

*Get an Unassigned Agreement (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|true|No description|

## GetUserDetailsResponse

<a id="schemagetuserdetailsresponse"></a>

```json
{
  "data": {
    "first_name": "Bear",
    "last_name": "Dog",
    "mobile_phone": "0456945832",
    "email": "bear@dog.com",
    "account": {
      "name": "Dog Bones Inc",
      "nickname": "dog-bones-inc",
      "abn": "129959040",
      "phone": "0418495033",
      "street_address": "98 Acme Avenue",
      "suburb": "Lead",
      "state": "NSW",
      "postcode": "2478"
    }
  }
}
```

### Properties

*Get User details (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|true|No description|

## SimulateIncomingPayIDPaymentRequest

<a id="schemasimulateincomingpayidpaymentrequest"></a>

```json
{
  "payid_email": "incoming@split.cash",
  "amount": 10000
}
```

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|payid_email|string|true|Receivable Contact PayID email (Min: 6 - Max: 256)|
|amount|integer|true|Amount in cents (Min: 1 - Max: 99999999999)|
|payment_description|string|false|Default:  "Simulated PayID payment"|
|payment_reference|string|false|Default:  "simulated-payid-payment"|
|from_bsb|string|false|Default: "014209"|
|from_account_number|string|false|Default: "12345678"|
|debtor_name|string|false|Default:  "Simulated Debtor"|
|debtor_legal_name|string|false|Default:  "Simulated Debtor Pty Ltd"|

## SimulateIncomingNPPBBANPaymentRequest

<a id="schemasimulateincomingnppbbanpaymentrequest"></a>

```json
{
  "to_bsb": "802919",
  "to_account_number": "88888888",
  "amount": 10000
}
```

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|to_bsb|string|true|Zepto float account BSB (usually 802919)|
|to_account_number|string|true|Zepto float account number|
|amount|integer|true|Amount in cents (Min: 1 - Max: 99999999999)|
|payment_description|string|false|Default: "Simulated NPP payment"|
|payment_reference|string|false|Default: "simulated-npp-payment"|
|from_bsb|string|false|Default: "014209"|
|from_account_number|string|false|Default: "12345678"|
|debtor_name|string|false|Default: "Simulated Debtor"|
|debtor_legal_name|string|false|Default: "Simulated Debtor Pty Ltd"|

## SimulateIncomingDEPaymentRequest

<a id="schemasimulateincomingdepaymentrequest"></a>

```json
{
  "to_bsb": "802919",
  "to_account_number": "88888888",
  "amount": 10000
}
```

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|to_bsb|string|true|Zepto float account BSB (usually 802919)|
|to_account_number|string|true|Zepto float account number|
|amount|integer|true|Amount in cents (Min: 1 - Max: 99999999999)|
|payment_reference|string|false|Max 18 characters. Default: "simulated-de-pymt"|
|from_bsb|string|false|Default: "014209"|
|from_account_number|string|false|Default: "12345678"|
|debtor_name|string|false|Max 16 characters. Default: "Simulated Debtor"|

## AddATransferRequest

<a id="schemaaddatransferrequest"></a>

```json
{
  "from_bank_account_id": "a79423b2-3827-4cf5-9eda-dc02a298d005",
  "to_bank_account_id": "0921a719-c79d-4ffb-91b6-1b30ab77d14d",
  "amount": 100000,
  "description": "Float account balance adjustment",
  "matures_at": "2021-06-06T00:00:00Z"
}
```

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|from_bank_account_id|string|true|The source float/bank account (UUID)|
|to_bank_account_id|string|true|The destination float/bank account (UUID)|
|amount|integer|true|Amount in cents (Min: 1 - Max: 99999999999)|
|description|string|true|Description for the Transfer|
|matures_at|string(date-time)|true|Date & time in UTC ISO8601 the Transfer should be processed. (Can not be earlier than the start of current day in Sydney AEST/AEDT)|

## AddATransferResponse

<a id="schemaaddatransferresponse"></a>

```json
{
  "data": {
    "ref": "T.11ub",
    "from_bank_account_id": "a79423b2-3827-4cf5-9eda-dc02a298d005",
    "to_bank_account_id": "0921a719-c79d-4ffb-91b6-1b30ab77d14d",
    "amount": 100000,
    "description": "Float account balance adjustment",
    "matures_at": "2021-06-06T00:00:00Z"
  }
}
```

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|true|No description|
|» ref|string|true|The Transfer request reference (T.*) (Min: 4 - Max: 8)|
|» from_bank_account_id|string|true|The source bank/float account (UUID)|
|» to_bank_account_id|string|true|The destination bank/float account (UUID|
|» amount|integer|true|The amount value provided (Min: 1 - Max: 99999999999)|
|» description|string|true|Description for the Transfer|
|» matures_at|string(date-time)|true|Date & time in UTC ISO8601 the Transfer should be processed. (Can not be earlier than the start of current day in Sydney AEST/AEDT)|

## GetATransferResponse

<a id="schemagetatransferresponse"></a>

```json
{
  "data": {
    "ref": "T.87xp",
    "from_bank_account_id": "a79423b2-3827-4cf5-9eda-dc02a298d005",
    "to_bank_account_id": "0921a719-c79d-4ffb-91b6-1b30ab77d14d",
    "amount": 47000,
    "description": "Deposit from my bank account",
    "matures_at": "2021-06-03T00:00:00Z"
  }
}
```

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|true|No description|
|» ref|string(uuid)|true|The Transfer request reference (T.*) (Min: 4 - Max: 8)|
|» initiator_id|string|false|Initiating Zepto Account|
|» from_bank_account_id|string|true|The source bank/float account (UUID)|
|» to_bank_account_id|string|true|The destination bank/float account (UUID|
|» amount|integer|true|The amount value provided (Min: 1 - Max: 99999999999)|
|» description|string|true|Description for the Transfer|
|» matures_at|string(date-time)|true|Date & time in UTC ISO8601 the Transfer should be processed. (Can not be earlier than the start of current day in Sydney AEST/AEDT)|

## ListAllTransfersResponse

<a id="schemalistalltransfersresponse"></a>

```json
{
  "data": [
    {
      "ref": "T.62xl",
      "from_bank_account_id": "a79423b2-3827-4cf5-9eda-dc02a298d005",
      "to_bank_account_id": "0921a719-c79d-4ffb-91b6-1b30ab77d14d",
      "amount": 47000,
      "description": "Deposit from my bank account",
      "matures_at": "2021-06-03T00:00:00Z"
    },
    {
      "ref": "T.87xp",
      "from_bank_account_id": "a79423b2-3827-4cf5-9eda-dc02a298d005",
      "to_bank_account_id": "0921a719-c79d-4ffb-91b6-1b30ab77d14d",
      "amount": 9700,
      "description": "Withdrawal June 2021",
      "matures_at": "2021-05-28T00:00:00Z"
    },
    {
      "ref": "T.87s4",
      "from_bank_account_id": "a79423b2-3827-4cf5-9eda-dc02a298d005",
      "to_bank_account_id": "0921a719-c79d-4ffb-91b6-1b30ab77d14d",
      "amount": 230,
      "description": "Transfer to my other Float account",
      "matures_at": "2021-05-03T00:00:00Z"
    }
  ]
}
```

### Properties

*List all Transfers (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|[object]|true|No description|

## ListAllWebhooksResponse

<a id="schemalistallwebhooksresponse"></a>

```json
{
  "data": [
    {
      "id": "13bd760e-447f-4225-b801-0777a15da131",
      "url": "https://webhook.site/a9a3033b-90eb-44af-9ba3-29972435d10e",
      "signature_secret": "8fad2f5570e6bf0351728f727c5a8c770dda646adde049b866a7800d59",
      "events": [
        "debit.cleared",
        "credit.cleared"
      ]
    }
  ]
}
```

### Properties

*List all Webhooks (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|[object]|true|No description|

## GetWebhookDeliveriesResponse

<a id="schemagetwebhookdeliveriesresponse"></a>

```json
{
  "data": [
    {
      "id": "957d40a4-80f5-4dd2-8ada-8242d5ad66c1",
      "event_type": "payout_request.added",
      "state": "completed",
      "response_status_code": 200,
      "created_at": "2021-09-02T02:24:50.000Z",
      "payload_data_summary": [
        {
          "ref": "PR.ct5b"
        }
      ]
    },
    {
      "id": "29bb9835-7c69-4ecb-bf96-197d089d0ec3",
      "event_type": "creditor_debit.scheduled",
      "state": "completed",
      "response_status_code": 200,
      "created_at": "2021-09-02T02:24:50.000Z",
      "payload_data_summary": [
        {
          "ref": "D.hyy9"
        },
        {
          "ref": "D.6st93"
        }
      ]
    }
  ]
}
```

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|data|[object]|false|No description|

## GetAWebhookDeliveryResponse

<a id="schemagetawebhookdeliveryresponse"></a>

```json
{
  "data": {
    "id": "957d40a4-80f5-4dd2-8ada-8242d5ad66c1",
    "webhook_id": "13bd760e-447f-4225-b801-0777a15da131",
    "event_type": "payout_request.added",
    "state": "completed",
    "payload": {
      "data": [
        {
          "ref": "PR.ct5b",
          "payout": {
            "amount": 1501,
            "matures_at": "2021-09-02T02:24:49.000Z",
            "description": "Payment from Incoming Test Payment Contact 014209 12345678 (Test Payment)"
          },
          "status": "approved",
          "created_at": "2021-09-02T02:24:49.000Z",
          "credit_ref": "C.p2rt",
          "matures_at": "2021-09-02T02:24:49.000Z",
          "initiator_id": "b50a6e92-a5e1-4175-b560-9e4c9a9bb4b9",
          "responded_at": "2021-09-02T02:24:49.000Z",
          "schedule_ref": null,
          "authoriser_id": "780f186c-80fd-42b9-97d5-650d99a0bc99",
          "status_reason": null,
          "your_bank_account_id": "b50a6e92-a5e1-4175-b560-9e4c9a9bb4b9",
          "authoriser_contact_id": "590be205-6bae-4070-a9af-eb50d514cec5",
          "authoriser_contact_initiated": true
        },
        {
          "event": {
            "at": "2021-09-02T02:24:49.000Z",
            "who": {
              "account_id": "20f4e3f8-2efc-48a9-920b-541515f1c9e3",
              "account_type": "Account",
              "bank_account_id": "b50a6e92-a5e1-4175-b560-9e4c9a9bb4b9",
              "bank_account_type": "BankAccount"
            },
            "type": "payment_request.added"
          }
        }
      ]
    }
  },
  "response_status_code": 200,
  "created_at": "2021-09-02T02:24:50.000Z"
}
```

### Properties

*Get a WebhookDelivery (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|true|No description|
|» id|string(uuid)|false|The Webhook Delivery ID|
|» webhook_id|string(uuid)|false|The Webhook ID|
|» state|string|false|The state of the webhook delivery.|
|» payload|object|false|Could be anything|
|» created_at|string(date-time)|false|When the webhook delivery was created|

#### Enumerated Values

|Property|Value|
|---|---|
|state|pending|
|state|completed|
|state|retrying|
|state|failed|

## RedeliverAWebhookDeliveryResponse

<a id="schemaredeliverawebhookdeliveryresponse"></a>

```json
{
  "data": {
    "id": "957d40a4-80f5-4dd2-8ada-8242d5ad66c1",
    "webhook_id": "13bd760e-447f-4225-b801-0777a15da131",
    "state": "pending"
  }
}
```

### Properties

*Resend a WebhookDelivery (response)*

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|true|No description|

