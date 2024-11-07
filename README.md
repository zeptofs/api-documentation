<img src="https://raw.githubusercontent.com/zeptofs/public_assets/master/images/zepto_logo_black.png" width="300" alt="Zepto Logo" title="Zepto Logo">

# Zepto API Documentation

Welcome to the Zepto API documentation source.

## How does it work?

- The Zepto API is documented using the [OpenAPI 3.0.0 specification](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md).
- The new [Swagger editor](http://editor.swagger.io/) was used to get the boilerplate done.
- The API spec is then converted to [Slate](https://github.com/lord/slate) friendly markdown with [Widdershins](https://github.com/mermade/widdershins).

## Get started

1. Clone the repo
2. `$ bundle install`
   - Having trouble running this on an m1 due to openssl errors when installing eventmachine?
     Try using `gem install eventmachine -v '1.2.7' -- --with-openssl-dir=$(brew --prefix openssl)`
3. `$ yarn install`
4. `$ bundle exec foreman start`
5. Browse to http://localhost:4567 to preview the documentation.
6. Edit the `source/openapi3/split.yaml` or any themes/templates. The preview should update a few seconds after
   you save your changes.
7. Changes to the YAML file will be built and output to the `source/`
   directory, so don't edit the build output in there.
8. Update the Changelog section of `source/openapi3/split.yaml`.
9. Commit both the YAML and the build output changes.

Note: Currently only changes to split.yaml will trigger the automatic update.

## Publishing changes

**Warning:** this script will push changes directly to Github pages. They will be publicly visible. You should only run this after your changes have been reviewed and merged.

`$ ./deploy.sh`

## Notes

- The Slate template/theme is mildly edited to suit our style.
- The same goes for Widdershin's conversion templates.

## Thanks

Thanks to the teams at Widdershins, Slate, Swagger and OpenAPI spec.
