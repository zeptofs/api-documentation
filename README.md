![Split Payments Logo](https://raw.githubusercontent.com/splitpayments/public_assets/master/images/Split_Logo_rgb.png)

Split API Documentation
===

Welcome to the Split API documentation source.

How does it work?
---

* The Split API is documented using the [OpenAPI 3.0.0 specification](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md).
* The new [Swagger editor](http://editor.swagger.io/) was used to get the boilerplate done.
* The API spec is then converted to [Slate](https://github.com/lord/slate) friendly markdown with [Widdershins](https://github.com/mermade/widdershins).

Get started
---

1. Clone the repo
2. `$ bundle install`
3. `$ yarn install`
4. Edit the `source/openapi3/split.yaml` or any themes/templates
5. `$ yarn run widdershins -e options.yml ./source/openapi3/split.yaml -o ./source/index.html.md`
    1. Preview: `$ bundle exec middleman server`
    1. Publish: `./deploy.sh`

Notes
---

* The Slate template/theme is mildly edited to suite our style.
* The same goes for Widdershin's conversion templates.

Thanks
---

Thanks to the teams at Widdershins, Slate, Swagger and OpenAPI spec.
