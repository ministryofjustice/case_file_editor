# Case File Editor

Edit digital case files.

## Current status

This is able to ingest JSON-formatted digital case files into an internal
model, validate the data, and export it again in JSON format.

Most validations are implemented, with the exception of those that require
knowledge of the whole case file. These are indicated with `# TODO` in the
`app/models` directory.

This is based on the JSON schema Version 1.1.0 Draft 5.

An example file can be found in `spec/fixtures/example_1.json`.

### Examples

#### Import

```ruby
dcf = CaseImporter.new(JSON.parse(casefile_as_json))
```

#### Validate

```ruby
RecursiveValidator.new(dcf).errors
```

```ruby
{:defendants=>{0=>{:signed_charge_sheet=>["is not included in the list"]}},
 :multimedia_evidence=>
   {0=>
     {:relied_upon_trial=>["is not included in the list"],
      :relied_upon_sentence=>["is not included in the list"]}}}
```

#### Export

```ruby
casefile_json = JSON.pretty_generate(CaseExporter.new(dcf).export)
```
