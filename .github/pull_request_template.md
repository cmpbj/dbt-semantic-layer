## Description and motivation

<!--

Describe your changes and why you are making them.

-->

## Changes to existing models:

<!--

Include this section if you are changing any existing model. Link any related pull request in your BI tool or provide merge instructions (for example, whether old models should be removed after merge or whether a full-refresh is required). Describe important updates.

-->

## Related links:
<!--
- List links to related tickets.
- (optional) Link to other files and resources, such as specific reports in a BI tool.
-->


## Validations

<!--
- Add here a screenshot of the validation using audit helper, as well as possible adjustments needed to remove
false negatives (for example: encoding issues in the external table, data typing, etc.)
-->

## Checklist:

<!--

This checklist is mainly useful as a reminder of small things that can be easily forgotten. It serves as a support tool, not as obstacles to overcome. Mark the applicable items with an `x`, add notes next to those that are not yet resolved, and remove items that are not relevant to this PR.

-->

- [ ] My pull request represents a logical unit of work.
- [ ] All models, whether changed directly by this PR or not, run successfully.
- [ ] My commits are related to the pull request and are clean.
- [ ] Tests:
    - [ ] All added/modified models and columns are documented and tested in `schema.yml` files.
    - [ ] All tests pass. **OR**
      _Check one option:_
    - [ ] There are no new test failures, even if an existing model was intentionally changed in this PR.
    - [ ] This PR causes new test failures and there is a plan to resolve them.
- [ ] I updated the README file.
