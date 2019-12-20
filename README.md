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
4. `$ bundle foreman start`
5. Browse to http://localhost:4567 to preview the documentation.
4. Edit the `source/openapi3/split.yaml` or any themes/templates. The preview should update a few seconds after
you save your changes.


Note: Currently only changes to split.yaml will trigger the automatic update.


Publishing changes
---
**Warning:** this script will push changes directly to Github pages. They will be publicly visible. You should only run this after your changes have been reviewed and merged.

`$ ./deploy.sh`

Notes
---

* The Slate template/theme is mildly edited to suite our style.
* The same goes for Widdershin's conversion templates.

Thanks
---

Thanks to the teams at Widdershins, Slate, Swagger and OpenAPI spec.
