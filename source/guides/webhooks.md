---
title: Webhooks
excerpt: Webhooks are used to notify your application of changes to the status of Agreements, Payment Requests, Credits and Debits, etc as they are processed through the system
category: 65ada3d7699b7900765d2ed5
hidden: false
---

# [AU] Webhooks | Zepto Help Center

Webhooks are used to notify your application of changes to the status of Agreements, Payment Requests, Credits and Debits, etc as they are processed through the system.

## We support two types of webhooks

## **Owner**

These webhooks are managed by the owner of the Zepto account and only report on events relating to the Zepto account. 

To create an Owner webhook:

## **Application**

These webhooks are managed by the Zepto OAuth2 application owner and will report on events relating to any authorised Zepto account (limited by scope)

To create an Application webhook:

## **Webhook Event Payload**

Each webhook event contains data relating to the event type. For example, when you receive an Agreement event, the payload will contain data relating to that agreement.

The webhook payload will also include metadata where available.
​
The best way to see example payloads for each type of webhook event is to try them out in the developer sandbox by creating a webhook and subscribing to all of the events.

*Note: that the payload for a single webhook event contains an array that may hold more than one transaction, so you'll need to loop through them all.* 

[![](https://downloads.intercomcdn.com/i/o/145843405/df2ba5b7f1439a35a18922bc/Screen+Shot+2019-09-02+at+5.12.39+pm.png?expires=1619761494&signature=b741439eec1691a83101e70a890a96a4c2ac673ed1522753b2a24f3586ccf0d2)](https://downloads.intercomcdn.com/i/o/145843405/df2ba5b7f1439a35a18922bc/Screen+Shot+2019-09-02+at+5.12.39+pm.png?expires=1619761494&signature=b741439eec1691a83101e70a890a96a4c2ac673ed1522753b2a24f3586ccf0d2)

If your application is not ready to receive webhooks but you want a quick way to see the events in action, you can use the [https:/webhook.site](https://www.webhook.site/) to quickly create a URL that you can use as the webhook URL when settings up webhooks in Zepto. Alternatively, you can also use [https://ngrok.com/](https://ngrok.com/) to allow webhook events to be posted to your local machine.

Once you have subscribed to all the events, you can try creating an Agreement, Payment Request or Payment in the sandbox. You can then see the events that have been sent to the configured webhook URL under the _Deliveries_ heading on the webhook detailed page.

[![](https://downloads.intercomcdn.com/i/o/145842706/9127f96c7741b97ba6e617e2/Screen+Shot+2019-09-02+at+5.36.44+pm.png?expires=1619761494&signature=3639e0f59afdb79748b96b0934dbe5d2639b726d47313495e605692d0a3e1fe6)](https://downloads.intercomcdn.com/i/o/145842706/9127f96c7741b97ba6e617e2/Screen+Shot+2019-09-02+at+5.36.44+pm.png?expires=1619761494&signature=3639e0f59afdb79748b96b0934dbe5d2639b726d47313495e605692d0a3e1fe6)

## **Knowing when credit to your account has cleared**

Transactions always have two parts, a debit and a credit. After using a Payment Request to get paid, your application can be notified when the debit from the debtor's account has cleared by subscribing to the **Creditor Debit cleared** event. 

Once the creditor debit has cleared, you can be notified when the credit to your account has cleared by subscribing to the **Credit Cleared** event.

The normal lifecycle of the creditor debit and credit events is shown below, and you can also subscribe to these events to keep your system updated.

Please also find an article attached [here](https://help.zepto.money/en/articles/4882892-webhook-event-flows), that will help you understand the webhooks events you will receive for the types of the transaction.

If you would like to check the configuration of your webhooks or redeliver specific webhooks you can refer to our article attached [here](https://help.zepto.money/en/articles/5806231-webhook-api-endpoints).

## Handling transaction failures

Transactions can fail for a number of reasons. The failure states include `rejected` , `returned` , `voided`  and `prefailed` . Subscribe to these webhook events to notify your system of transaction failures. For more information on all the status values, please refer to the [transaction lifecycle developer documentation](https://docs.zepto.money/#lifecycle).

**Is Your Delivery Showing A Different State Than The Delivery Type?**

When webhooks are sent, our system will populate the payload fields using the current state of the object that it relates to.

For a transaction that uses an NPP channel, it essentially clears straight away and the credit status moves to `cleared` very quickly. So, when the fields are populated for the `debtor_credit.xxxx` webhook notification, the current status of the credit is actually cleared which is what may be returned back to you.

Please be mindful that you would still receive a `debtor_credit.cleared` event.

## Our Delivery Promises

Feel free to reach out if you have further questions by emailing us directly at [support@zepto.com.au](mailto:support@zepto.com.au) or clicking on the blue bubble icon from the corner of the screen.

