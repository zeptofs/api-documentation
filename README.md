<img src="https://raw.githubusercontent.com/zeptofs/public_assets/master/images/zepto_logo_black.png" width="300" alt="Zepto Logo" title="Zepto Logo">

# Zepto API Documentation

Welcome to the Zepto API documentation source.

Zepto's API Documentation is hosted at [docs.zeptopayments.com](https://docs.zeptopayments.com/) and powered by [readme](https://readme.com/). 

Note that some parts of the docs published at [docs.zeptopayments.com](https://docs.zeptopayments.com/) are maintained outside of this repo. 


## API Reference

### How does it work?

- The Zepto API is documented using the [OpenAPI 3.0.0 specification](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md).
- The new [Swagger editor](http://editor.swagger.io/) was used to get the boilerplate done.
- The API spec is then converted to [Slate](https://github.com/lord/slate) friendly markdown with [Widdershins](https://github.com/mermade/widdershins).

### Starting application locally

```sh
make start # Ctrl+C to stop
```

### Making changes

1. With the application running, edit the `source/openapi3/split.yaml` or any themes/templates. The preview should update a few seconds after
   you save your changes.
2. Changes to the YAML file will be built and output to `source/index.html.md`, courtesy of Guard (see the [Guardfile](Guardfile)). 
   (Don't edit the output file directly).
3. Commit both the YAML and the build output changes.
4. Create an [Internal Release Note](https://zeptoau.atlassian.net/wiki/spaces/IRN) so that the (Merchant-facing) API Changelog can be updated accordingly.

Note: Currently only changes to split.yaml will trigger the automatic update.

## Developer Guides

### Making changes

1. Make changes to the Developer Guides directly in the [source/guides](source/guides) markdown files (there is no need for the application to be running). For example:
- [source/guides/zepto-api.md](source/guides/zepto-api.md)
- [source/guides/webhooks.md](source/guides/webhooks.md)
2. Commit your changes.
3. Create an [Internal Release Note](https://zeptoau.atlassian.net/wiki/spaces/IRN) so that the (Merchant-facing) API Changelog can be updated accordingly.


## Publishing changes

**Warning:** this script will push changes directly to Github pages. They will be publicly visible. You should only run this after your changes have been reviewed and merged.

```sh
make publish
```

## Notes

- The Slate template/theme is mildly edited to suit our style.
- The same goes for Widdershin's conversion templates.

## Thanks

Thanks to the teams at Widdershins, Slate, Swagger and OpenAPI spec.
