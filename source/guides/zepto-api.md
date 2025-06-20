---
title: Zepto API
excerpt: Zepto allows you to make, get and manage payments using nothing but bank accounts.
category: 65ada3d7699b7900765d2ed5
hidden: false
---

# Zepto

Zepto allows you to make, get and manage payments using nothing but bank accounts.

It is important to understand that there are 2 main ways Zepto can be used for maximum flexibility:

1. Between Zepto accounts.
2. Between a Zepto account and anyone.

Due to the above, certain endpoints and techniques will differ slightly depending on who you are interacting with. You can find more on this in the [Making payments](doc:zepto-api#making-payments) and [Getting paid](doc:zepto-api#getting-paid) guides.

And for all kinds of How To's and Recipes, head on over to our [Help Guide](https://help.zepto.money/en/).

# Conventions

- Authentication is performed using OAuth2. See the [Get started](doc:zepto-api#get-started) and [Authentication & Authorisation](doc:zepto-api#authentication-and-authorisation) guides for more.
- All communication is via `https` and supports **only** `TLSv1.2`.
- Production API: `https://api.zeptopayments.com/`.
- Production UI: `https://go.zeptopayments.com/`.
- Sandbox API: `https://api.sandbox.zeptopayments.com/`.
- Sandbox UI: `https://go.sandbox.zeptopayments.com/`.
- Data is sent and received as JSON.
- Clients should include the `Accepts: application/json` header in their requests.
- Currencies are represented by 3 characters as defined in [ISO 4217](http://www.xe.com/iso4217.php).
- Dates & times are returned in UTC using [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format with second accuracy. With requests, when no TZ is supplied, the configured TZ of the authenticated user is used, or `Australia/Sydney` if no TZ is configured.
- Amounts are always in cents with no decimals unless otherwise stated.
- Zepto provides static public IP addresses for all outbound traffic, including webhooks.
  - Sandbox IP: `13.237.142.60`
  - Production IPs: `52.64.11.67` and `13.238.78.114`

# System Status

Check the platform status, or subscribe to receive notifications at [status.zeptopayments.com](https://status.zeptopayments.com/).
If you would like to check platform status programmatically, please refer to [status.zeptopayments.com/api](https://status.zeptopayments.com/api).

# Breaking Changes

A breaking change is assumed to be:

- Renaming a parameter (request/response)
- Removing a parameter (request/response)
- Changing a parameter type (request/response)
- Renaming a header (request/response)
- Removing a header (request/response)
- Application of stricter validation rules for request parameters
- Reducing the set of possible enumeration values for a request
- Changing a HTTP response status code

We take backwards compatibility very seriously, and will make every effort to ensure this never changes. In the unfortunate (and rare) case where a breaking change can not be avoided, these will be announced well in
advance, enabling a transition period for API consumers.

The following are not assumed to be a breaking change and must be taken into account by API consumers:

- Addition of optional new parameters in request
- Addition of new parameters in response
- Addition of new headers in request
- Reordering of parameters in response
- Softening of validation rules for request parameters
- Increasing the set of possible enumeration values

In the case of non breaking changes, a transition period may not be provided, meaning the possibility of such changes occurring must be considered in consumers' logic so as not to break any integrations with both API and Webhooks.

# Guides

## Try it out

The best way to familiarise yourself with our API is by interacting with it.

We've preloaded a collection with all our endpoints for you to use in Postman.
Before you start, **import a copy** of our API collection:

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/3168734-baa5ff70-4bc2-44d5-9ba6-fcb61839ff41?action=collection%2Ffork&collection-url=entityId%3D3168734-baa5ff70-4bc2-44d5-9ba6-fcb61839ff41%26entityType%3Dcollection%26workspaceId%3D6400ea2b-bb46-421e-a88c-a8625653c35a#?env%5BSplit%20Payments%20Public%20Sandbox%5D=W3sia2V5Ijoic2l0ZV9ob3N0IiwidmFsdWUiOiJodHRwczovL2dvLnNhbmRib3guc3BsaXQuY2FzaCIsImVuYWJsZWQiOnRydWV9LHsia2V5IjoiYXBpX2hvc3QiLCJ2YWx1ZSI6Imh0dHBzOi8vYXBpLnNhbmRib3guc3BsaXQuY2FzaCIsImVuYWJsZWQiOnRydWV9LHsia2V5Ijoib2F1dGgyX2FwcGxpY2F0aW9uX2lkIiwidmFsdWUiOiIiLCJlbmFibGVkIjp0cnVlfSx7ImtleSI6Im9hdXRoMl9zZWNyZXQiLCJ2YWx1ZSI6IiIsImVuYWJsZWQiOnRydWV9LHsia2V5Ijoic2NvcGUiLCJ2YWx1ZSI6InB1YmxpYyBhZ3JlZW1lbnRzIGJhbmtfYWNjb3VudHMgYmFua19jb25uZWN0aW9ucyBjb250YWN0cyBwYXltZW50cyBwYXltZW50X3JlcXVlc3RzIHJlZnVuZF9yZXF1ZXN0cyB0cmFuc2FjdGlvbnMgcmVmdW5kcyBvcGVuX2FncmVlbWVudHMgb2ZmbGluZV9hY2Nlc3MiLCJlbmFibGVkIjp0cnVlfSx7ImtleSI6Imlzbzg2MDFfbm93IiwidmFsdWUiOiIiLCJlbmFibGVkIjp0cnVlfSx7ImtleSI6ImFjY2Vzc190b2tlbiIsInZhbHVlIjoiIiwiZW5hYmxlZCI6dHJ1ZX0seyJrZXkiOiJyZWZyZXNoX3Rva2VuIiwidmFsdWUiOiIiLCJlbmFibGVkIjp0cnVlfV0=)

Okay, let's get things setup!

1. **Create a Zepto account**
   If you haven't already, you'll want to create a sandbox Zepto account at <https://go.sandbox.zeptopayments.com>
2. **Register your application with Zepto**
   Sign in and create an OAuth2 application: <https://go.sandbox.zeptopayments.com/oauth/applications>.
   [![Zepto OAuth2 app create](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/split_oauth2_app_create.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/split_oauth2_app_create.png)
3. **Generate personal access tokens**
   The quickest way to access your Zepto account via the API is using personal access tokens. Click on your newly created application from your [application list](https://go.sandbox.zeptopayments.com/oauth applications) and click on
   [![Zepto personal OAuth2 tokens](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/split_personal_access_tokens_empty.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/split_personal_access_tokens_empty.png)
   _(You'll have the option to give the token a title)_
   > **_NOTE:_** Please note that personal access tokens do not expire.
4. **Use personal access token in Postman**
   You can use this `access_token` to authorise any requests to the Zepto API in Postman by choosing the **Bearer Token** option under the **Authorization** tab.
   [![Postman use personal OAuth2 tokens](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/postman_use_personal_access_token.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/postman_use_personal_access_token.png)
5. **Make an API request!**
   You are now ready to interact with your Zepto account via the API! Go ahead and send a request using Postman.
   [![Postman use personal OAuth2 tokens](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/postman_request_response.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/postman_request_response.png)

## Get started

This guide will help you setup an OAuth2 app in order to get authenticated & authorised to communicate with the Zepto API.

**Before you start:**

- We use the term **user** below but the user can be a third party or the same user that owns the OAuth2 application.
- As noted below, some access tokens expire every 2 hours. To get a new access token use the [refresh grant strategy](doc:zepto-api#authentication-and-authorisation) to swap a refresh token for a new access token.

1. **Create a Zepto account**
   If you haven't already, you'll want to create a sandbox Zepto account at <https://go.sandbox.zeptopayments.com>.
2. **Choose authentication method**
   All requests to the Zepto API require an `access_token` for authentication. There are two options for obtaining these tokens, the correct option will depend on your use case:
   - **Personal access token** If you only need to access your own Zepto account via the API, then using personal access tokens are the most straight-forward way. Refer to [Personal access token](doc:zepto-api#personal-access-token) to setup. These tokens do not expire so no refreshing is required.
   - **OAuth grant flow** When you require your application to act on behalf of other Zepto accounts you'll need to implement the OAuth grant flow process. Refer to [OAuth grant flow guide](doc:zepto-api#oauth-grant-flow) to setup. There is also an [OAuth grant flow tutorial](doc:zepto-api#oauth-grant-flow-tutorial). These access tokens expire every 2 hours, unless the `offline_access` scope is used in which case the tokens will not expire.

## Personal access token

If you're looking to only access your own account via the API, you can generate a personal access token from the UI. These tokens do not expire, but can be deleted. To do this:

1. Sign in to your Zepto account and [create an application](https://go.sandbox.zeptopayments.com/oauth/applications) if you haven't already. Click on your application from your [application list](https://go.sandbox.zeptopayments.com/oauth/applications) and click on **Personal access**.
   [![Zepto locate personal OAuth2 tokens](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/split_personal_access_tokens_empty.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/split_personal_access_tokens_empty.png)
   _(You'll have the option to give the token a title)_
   [![Zepto personal OAuth2 tokens](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/split_personal_access_token.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/split_personal_access_token.png)
2. Now that you have an `access_token` you can interact with your Zepto account via the API.
   To do so, you must simply append the access token to the header of any API request: `Authorization: Bearer {access_token}`

## OAuth grant flow

1. **Register your application with Zepto**

   Once you've got your account up and running, sign in and create an OAuth2 profile for your application: <https://go.sandbox.zeptopayments.com/oauth/applications>

   | Parameter        | Description                                                                                                                                              |
   | ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
   | **Name**         | The name of your application. When using the _Authorisation Grant Flow_, users will see this name as the application requesting access to their account. |
   | **Redirect URI** | Set this to your application's endpoint charged with receiving the authorisation code.                                                                   |

2. **Obtain an authorisation code**

   Construct the initial URL the user will need to visit in order to grant your application permission to act on his/her behalf. The constructed URL describes the level of permission ([`scope`](doc:zepto-api#scopes)), the application requesting permission (`client_id`) and where the user gets redirected once they've granted permission (`redirect_uri`).

   The URL should be formatted to look like this:
   `https://go.sandbox.zeptopayments.com/oauth/authorize?response_type=code&client_id={client_id}&redirect_uri={redirect_uri}&scope={scope}`

   | Parameter       | Description                                                                                |
   | --------------- | ------------------------------------------------------------------------------------------ |
   | `response_type` | Always set to `code`                                                                       |
   | `client_id`     | This is your `Application ID` as generated when you registered your application with Zepto |
   | `redirect_uri`  | URL where the user will get redirected along with the newly generated authorisation code   |
   | `scope`         | The [scope](doc:zepto-api#scopes) of permission you're requesting                          |

3. **Exchange the authorisation code for an access token**

   When the user visits the above-mentioned URL, they will be presented with a Zepto login screen and then an authorisation screen:

   [![Authorise OAuth2 app](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/zepto_oauth2_authorize.png)](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/zepto_oauth2_authorize.png)

   After the user has authorised your application, they will be returned to your application at the URL specified in `redirect_uri` along with the `code` query parameter as the authorisation code.

   Finally, the authorisation code can then be exchanged for an access token and refresh token pair by POSTing to: `https://go.sandbox.zeptopayments.com/oauth/token`

   **Note** The authorisation code is a ONE-TIME use code. It will not work again if you try to POST it a second time.

   | Parameter       | Description                                                                                |
   | --------------- | ------------------------------------------------------------------------------------------ |
   | `grant_type`    | Set to `authorization_code`                                                                |
   | `client_id`     | This is your `Application ID` as generated when you registered your application with Zepto |
   | `client_secret` | This is your `Secret` as generated when you registered your application with Zepto         |
   | `code`          | The authorisation code returned with the user (ONE-TIME use)                               |
   | `redirect_uri`  | Same URL used in step 3                                                                    |

4. **Wrap-up**

   Now that you have an access token and refresh token, you can interact with the Zepto API as the user related to the access token.
   To do so, you must simply append the access token to the header of any API request: `Authorization: Bearer {access_token}`

## OAuth grant flow tutorial

The OAuth grant flow process is demonstrated using Postman in the steps below.

Before you start, load up our API collection:

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/3168734-baa5ff70-4bc2-44d5-9ba6-fcb61839ff41?action=collection%2Ffork&collection-url=entityId%3D3168734-baa5ff70-4bc2-44d5-9ba6-fcb61839ff41%26entityType%3Dcollection%26workspaceId%3D6400ea2b-bb46-421e-a88c-a8625653c35a#?env%5BSplit%20Payments%20Public%20Sandbox%5D=W3sia2V5Ijoic2l0ZV9ob3N0IiwidmFsdWUiOiJodHRwczovL2dvLnNhbmRib3guc3BsaXQuY2FzaCIsImVuYWJsZWQiOnRydWV9LHsia2V5IjoiYXBpX2hvc3QiLCJ2YWx1ZSI6Imh0dHBzOi8vYXBpLnNhbmRib3guc3BsaXQuY2FzaCIsImVuYWJsZWQiOnRydWV9LHsia2V5Ijoib2F1dGgyX2FwcGxpY2F0aW9uX2lkIiwidmFsdWUiOiIiLCJlbmFibGVkIjp0cnVlfSx7ImtleSI6Im9hdXRoMl9zZWNyZXQiLCJ2YWx1ZSI6IiIsImVuYWJsZWQiOnRydWV9LHsia2V5Ijoic2NvcGUiLCJ2YWx1ZSI6InB1YmxpYyBhZ3JlZW1lbnRzIGJhbmtfYWNjb3VudHMgYmFua19jb25uZWN0aW9ucyBjb250YWN0cyBwYXltZW50cyBwYXltZW50X3JlcXVlc3RzIHJlZnVuZF9yZXF1ZXN0cyB0cmFuc2FjdGlvbnMgcmVmdW5kcyBvcGVuX2FncmVlbWVudHMgb2ZmbGluZV9hY2Nlc3MiLCJlbmFibGVkIjp0cnVlfSx7ImtleSI6Imlzbzg2MDFfbm93IiwidmFsdWUiOiIiLCJlbmFibGVkIjp0cnVlfSx7ImtleSI6ImFjY2Vzc190b2tlbiIsInZhbHVlIjoiIiwiZW5hYmxlZCI6dHJ1ZX0seyJrZXkiOiJyZWZyZXNoX3Rva2VuIiwidmFsdWUiOiIiLCJlbmFibGVkIjp0cnVlfV0=)

**A screencast of this process is also available:
<https://vimeo.com/246203244>.**

1. **Create a Zepto account**

   If you haven't already, you'll want to create a sandbox Zepto account at <https://go.sandbox.zeptopayments.com>

2. **Register your application with Zepto**

   Sign in and create an OAuth2 application: <https://go.sandbox.zeptopayments.com/oauth/applications>.

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

> **_NOTE:_** Remember to select the access token everytime you try
> a new endpoint. Have fun!

## Authentication and Authorisation

Zepto uses OAuth2 over https to manage authentication and authorisation.

OAuth2 is a protocol that lets external applications request permission from another Zepto user to send requests on their behalf without getting their password.

This is preferred over Basic Authentication because access tokens can be limited by scope and can be revoked by the user at any time.

New to OAuth2? DigitalOcean has a fantastic 5 minute [introduction to OAuth2](https://www.digitalocean.com/community/tutorials/an-introduction-to-oauth-2#grant-type-authorization-code).

We currently support the **authorisation code** and **refresh token** grants.

### Authorisation Code Grant

This type of grant allows your application to act on behalf of a user. If you've ever used a website or application with your

Google, Twitter or Facebook account, this is the grant being used.

See the [Get Started guide](doc:zepto-api#get-started) for step by step details on how to use this grant.

### Refresh Token Grant

> Code sample

```
curl -F "grant_type=refresh_token" \
      -F "client_id={{oauth2_application_id}}" \
      -F "client_secret={{oauth2_application_secret }}" \
      -F "refresh_token={{refresh_token}}" \
      -X POST https://go.sandbox.zeptopayments.com/oauth/token
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

> **_NOTE:_**
> The `refresh_token` gets regenerated and sent alongside the new `access_token`. In other words, `refresh_token`s are single use so you'll want to store the newly generated `refresh_token` everytime you use it to get a new `access_token`

## Making payments

In order to payout funds, you'll be looking to use the [Payments](doc:zepto-api#Zepto-API-Payments) endpoint. Whether you're paying out another Zepto account holder or anyone, the process is the same:

1. Add the recipient to your [Contact](doc:zepto-api#add-a-contact) list.

2. [Make a Payment](doc:zepto-api#make-a-payment) to your Contact.

Common use cases:

- Automated payout disbursement (Referal programs, net/commission payouts, etc...)

- Wage payments

- Gig economy payments

- Lending

## Getting paid

### POSTing a [Payment Request](doc:zepto-api#Zepto-API-Payment-Requests)

Provides the ability to send a Payment Request (get paid) to any Contact that has an accepted Agreement in place.

To send a Payment Request to a Contact using the API, you must first have an accepted [Agreement](https://docs.zeptopayments.com/reference/listoutgoingagreements) with them.

To do so, you can send them an [Open Agreement link](https://help.zepto.money/agreements/open-agreement) or [Unassigned Agreement link](http://help.zepto.money/agreements/unassigned-agreement) for them to [Select & verify their bank account](https://help.zepto.money/bank-accounts/instant-account-verification-iav) and accept the Agreement.

Having this in place will allow any future Payment Requests to be automatically approved and processed as per the Agreement terms.

Common use cases:

- Subscriptions

- On-account balance payments

- Bill smoothing

- Repayment plans

Example flow embedding an [Open Agreement link](https://help.zepto.money/agreements/open-agreement) using an iFrame in order to automate future Payment Request approvals:

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
        "about": "https://docs.zepto.money/"
      },
      "meta": {
        "resource_ref": "PB.1a4"
      }
    }
  ]
}
```

The Zepto API supports idempotency for safely retrying requests without accidentally performing the same operation twice.

For example, if a [Make a Payment] is `POST`ed and a there is a network connection error, you can retry the Payment with the same idempotency key to guarantee that only a single Payment is created. In case an idempotency key is not supplied and a Payment is retried, we would treat this as two different payments being made.

To perform an idempotent request, provide an additional `Idempotency-Key:<key>` header to the request.

You can pass any value (up to 256 characters) as the key but we suggest [V7 UUIDs](https://uuid7.com/) or another appropriately random string.

Keys expire after 24 hours. If there is a subsequent request with the same idempotency key within the 24 hour period, we will return a `409 Conflict`.

- The `meta.resource_ref` value is the reference of the resource that was previously created with the conflicting idempotency key.

- The `Idempotency-Key` header is required when interacting with endpoints that support it.

- Only the `POST` action for the Payments, Payment Requests, Transfers and Refunds endpoints require the use of the `Idempotency-Key`.

- Endpoints that use the `GET` or `DELETE` actions are idempotent by nature.

- A request that quickly follows another with the same idempotency key may return with `503 Service Unavailable`. If so, retry the request after the number of seconds specified in the `Retry-After` response header.

Currently the following `POST` requests can be made idempotent. We **require** sending a unique `Idempotency-Key` header when making those requests to allow for safe retries:

- [Request Payment](doc:zepto-api#request-payment)

- [Make a Payment](doc:zepto-api#make-a-payment)

- [Issue a Refund](doc:zepto-api#issue-a-refund)

- [Add a Transfer](doc:zepto-api#add-a-transfer)

## Error responses

> Example detailed error response

```json
{
  "errors": [
    {
      "title": "A Specific Error",
      "detail": "Details about the error",
      "links": {
        "about": "https://docs.zepto.money/..."
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

- Authentication

- Request types

- Idempotency

All other errors relating to Zepto specific resources(e.g. Contacts) will return the **Resource error response** style.

### 403 errors

**403 errors** are generally returned from any of our endpoints if your application does not have the required authorisation. This is usually due to:

- An [invalid/expired `access_token`](doc:zepto-api#authentication-and-authorisation); or

- The required **scopes** not being present when setting up your [OAuth application](https://go.sandbox.zeptopayments.com/oauth/applications); or

- The required **scopes** not being present in the [authorisation code link](doc:zepto-api#oauth-grant-flow) used to present your user with an authorisation request.

## Speeding up onboarding

Consider the following scenario:

> Zepto is integrated in your application to handle payments.
>
> A customer would like to use Zepto but does not yet have Zepto account.
>
> You already have some information about this customer.

Given the above, in a standard implementation where a customer enables/uses Zepto within your application, these are the steps they would follow:

1. Click on some sort of button within your app to use Zepto.

2. They get redirected to the Zepto sign in page (possibly via a popup or modal).

3. Since they don't yet have a Zepto account, they would click on sign up.

4. They would fill in all their signup details and submit.

5. They would be presented with the [authorisation page](https://raw.githubusercontent.com/zeptofs/public_assets/master/images/oauth2_app_authorise.png).

6. They would click the "Authorise" button and be redirected to your app.

Whilst not too bad, we can do better!

In order to speed up the process, we allow query string params to be appended to the [authorisation URL](doc:zepto-api#get-started). For instance, if we already have some information about the customer and know they probably don't have a Zepto account, we can embed this information in the authorisation URL.

**Supported query string parameters**

| Parameter                                           | Description                                                                                                                                                                    |
| --------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `landing`                                           | Accepted value: `sign_up`. What page the user should see first if not already signed in Default is the sign in page.Deprecated values: `business_sign_up`, `personal_sign_up`. |
| `nickname`                                          | Only letters, numbers, dashes and underscores are permitted.                                                                                                                   |
| This will be used to identify the account in Zepto. |                                                                                                                                                                                |
| `name`                                              | Business account only. Business name.                                                                                                                                          |
| `abn`                                               | Business account only. Business ABN.                                                                                                                                           |
| `phone`                                             | Business account only. Business phone number.                                                                                                                                  |
| `street_address`                                    |                                                                                                                                                                                |
| `suburb`                                            |                                                                                                                                                                                |
| `state`                                             | See the sign up page for accepted values                                                                                                                                       |
| `postcode`                                          |                                                                                                                                                                                |
| `first_name`                                        |                                                                                                                                                                                |
| `last_name`                                         |                                                                                                                                                                                |
| `mobile_phone`                                      |                                                                                                                                                                                |
| `email`                                             |                                                                                                                                                                                |

All values should be [URL encoded](https://en.wikipedia.org/wiki/Query_string#URL_encoding).

As an example, the following authorisation URL would display the **personal sign up** & prefill the first name field with **George**:

`https://go.sandbox.zeptopayments.com/oauth/authorize?response_type=code&client_id=xxx&redirect_uri=xxx&scope=xxx&landing=sign_up&first_name=George`

You can also pass the values directly to the sign up page outside of the OAuth2 authorisation process. Click on the following link to see the values preloaded:
[https://go.sandbox.zeptopayments.com/business/sign_up?name=GeorgeCo&nickname=georgeco&first_name=George](https://go.sandbox.zeptopayments.com/business/sign_up?name=GeorgeCo&nickname=georgceco&first_name=George).

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

- Failure Code

- Failure Title

- Failure Details

## DE Transaction failures

### Using failure codes

> - [DE credit failure codes](https://help.zepto.money/en/articles/5633407-au-transaction-failure-responses#h_b2229b3745)
> - [DE debit failure codes](https://help.zepto.money/en/articles/5633407-au-transaction-failure-responses#h_b15d7bd439)

To simulate a transaction failure, create a Payment or Payment Request with an amount corresponding to the desired failure code.

For example:

- DE amount `$1.05` will cause the credit transaction to fail, triggering the credit failure code `E105` (Account Not Found).

- DE amount `$2.03` will cause the debit transaction to fail, triggering the debit failure code `E203` (Account Closed).

### Example scenarios

1. Pay a contact with an invalid account number:

```
* Initiate a Payment for `$1.05`.
* Zepto will mimic a successful debit from your bank account.
* Zepto will mimic a failure to credit the contact's bank account.
* Zepto will automatically create a `payout_reversal` credit transaction back to your bank account.
```

2. Request payment from a contact with a closed bank account:

```
* Initiate a Payment Request for `$2.03`.
* Zepto will mimic a failure to debit the contact's bank account.
```

## NPP Payment failures

### Using failure codes

> - [NPP credit failure codes](https://help.zepto.money/en/articles/5633407-au-transaction-failure-responses#h_81961f33a0)

To simulate a transaction failure, create a Payment with an amount corresponding to the desired failure code.

For example:

- NPP amount `$3.02` will cause the transaction to fail, triggering credit failure code `E302` (BSB Not NPP Enabled).

- NPP amount `$3.04` will cause the transaction to fail, triggering credit failure code `E304` (Account Not Found).

You will receive all the same notifications as if this happened in our live environment. We recommend you check out our article on [what happens when an NPP Payment fails](https://help.zepto.money/en/articles/4405560-what-happens-when-an-npp-payment-fails) to learn more about what happens when an NPP Payment is unable to process.

## NPP Payment channel-switching failures

### Using failure codes

To simulate a transaction failure across both NPP and DE channels, create a Payment with an amount corresponding to the desired [DE credit failure code](https://help.zepto.money/en/articles/5633407-au-transaction-failure-responses#h_b2229b3745). The NPP leg of the payment will fail with error code E303 (this is to facilitate channel-switching where the transaction is set up to do so). If the transaction switches channels the DE leg of the payment will fail with the [DE credit failure code](https://help.zepto.money/en/articles/5633407-au-transaction-failure-responses#h_b2229b3745) that corresponds to the amount.

For example:

- payment amount `$1.02` will fail with code `E303` (Account Not NPP Enabled). If the payment channel-switches it will also fail DE processing with code `E102` (Payment Stopped).

- payment amount `$1.05` will fail with code `E303` (Account Not NPP Enabled). If the payment channel-switches it will also fail DE processing with code `E105` (Account Not Found).

- payment amount `$1.10` will succeed NPP processing, as there is no corresponding DE credit failure code for that amount.

## Instant account verification accounts

When using any of our hosted solutions ([Payment Requests](https://help.zepto.money/en/?q=payment+request),
[Open Agreements](https://help.zepto.money/agreements/open-agreement) or
[Unassigned Agreements](http://help.zepto.money/agreements/unassigned-agreement)) you may want to test the [Instant Account Verification (IAV)](http://help.zepto.money/bank-accounts/instant-account-verification-iav) process where we accept online banking credentials to validate bank account access. To do so, you can use the following credentials:

| Login      | Password      |
| ---------- | ------------- |
| `12345678` | `TestMyMoney` |

> **_NOTE:_** The credentials will work with any of the available financial institutions.

# Configuration

## Scopes

Scopes define the level of access granted via the OAuth2 authorisation process. As a best practice, only use the scopes your application will require.

| Scope              | Description                                |
| ------------------ | ------------------------------------------ |
| `public`           | View user's public information             |
| `agreements`       | Manage user's Agreements                   |
| `bank_accounts`    | Manage user's Bank Accounts                |
| `bank_connections` | Manage user's Bank Connections             |
| `contacts`         | Manage user's Contacts                     |
| `open_agreements`  | Manage user's Open Agreements              |
| `payments`         | Manage user's Payments                     |
| `payment_requests` | Manage user's Payment Requests             |
| `refunds`          | Manage user's Refunds                      |
| `transfers`        | Manage user's Transfers                    |
| `transactions`     | Access user's Transactions                 |
| `webhooks`         | Manage user's Webhook events               |
| `offline_access`   | Create non-expiring access tokens for user |

> **_NOTE:_** Please use `offline_access` with discretion, as you'll have no direct way to invalidate the token. Please contact Zepto immediately if any token may have potentially been compromised.

## Pagination

> Example response headers

```
Link: <http://api.sandbox.zeptopayments.com/contacts?page=2>; rel="next"

Per-Page: 25

```

Pagination information can be located in the response headers: `Link` & `Per-Page`

All collection endpoints are paginated to `Per-Page: 25` by default. (`100` per page is max, any value above will revert to `100`)

You can control the pagination by including `per_page=x` and/or `page=x` in the endpoint URL params.

The `Link` header will be optionally present if a "next page" is available to navigate to. The next page link is identified with `rel="next"`

> **Legacy Pagination**: Some existing users may still be on a transitional legacy version of pagination.
>
> The Legacy version returns some extra **deprecated header values: `Total` plus `rel="last"` & `rel="prev"` in `Link`**.
>
> Please transition to only using the `rel="next"` from the `Link` header, as all other values are deprecated.

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

- **For Payments**, the party being credited will see the designated remitter name along the entry on their bank statement.

- **For Payment Requests**, the party being debited will see the designated remitter name along the entry on their bank statement.

> **_NOTE:_** The remitter name MUST be between `3` and `16` characters.

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
