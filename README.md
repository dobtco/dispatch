Dispatch [![Circle CI](https://circleci.com/gh/dobtco/dispatch.svg?style=shield)](https://circleci.com/gh/dobtco/dispatch) [![Code Climate](https://codeclimate.com/github/dobtco/dispatch/badges/gpa.svg)](https://codeclimate.com/github/dobtco/dispatch) [![Test Coverage](https://codeclimate.com/github/dobtco/dispatch/badges/coverage.svg)](https://codeclimate.com/github/dobtco/dispatch/coverage) [![Dependency Status](https://gemnasium.com/badges/github.com/dobtco/dispatch.svg)](https://gemnasium.com/github.com/dobtco/dispatch)
====

![screenshot of Dispatch home page](docs/screenshot.png)

Dispatch is an application for cities to advertise their contract opportunities. It was inspired by Beacon, a Code for America 2015 fellowship project, but it has been completely rewritten from the ground-up for solidity and [customizability](docs/customization.md). Its initial development has been financed by a contract with the City of Philadelphia.

Dispatch is developed by [The Department of Better Technology](https://www.dobt.co/screendoor/), the creators of [Screendoor](https://www.dobt.co/screendoor/), a cloud-hosted solution for government forms and workflows. Dispatch integrates with Screendoor for proposal submission and review, but this integration is not required in order to use Dispatch.

## For governments

Dispatch is a powerful tool that is [proven by the White House and Small Business Administration](https://www.whitehouse.gov/blog/2013/05/15/rfp-ez-delivers-savings-taxpayers-new-opportunities-small-business) to broaden your vendor pool and decrease the cost of your IT procurements. (Dispatch contains a superset of RFP-EZ's functionality.)

It can integrate with your existing procurement system, and will eventually be able to replace costly enterprise contract listing systems.

Contact [hello@dobt.co](mailto:hello@dobt.co) for more information.

## For vendors

If you do work with government, you're probably familiar with contract listing systems that [look like this](https://dobt-captured.s3.amazonaws.com/ajb/Construction_Opportunities__Contracting_Opportunities__City_of_Oakland__California_2016-04-25_11-48-24.png). You're used to a long and bug-ridden registration process, and you probably check these sites multiple times a week to see if any new contracts have been posted, since there's no way to receive an email digest of new results that match a saved search.

Enter Dispatch. Governments using Dispatch will have a modern contracting portal, including easy registration, searching, and email alerts.

Government officials truly want to make it easier for you to do business with them, but sometimes they don't know where to start. Do them a favor and point them to Dispatch.

## For developers

Dispatch is a Rails application, backed by a PostgreSQL database. It does not have any other significant dependencies, which makes it easy to deploy and maintain.

[Read more about developing Dispatch &rarr;](docs/setting_up_a_development_environment.md)

## List of Deployments

| Name | Link | Repo |
| --- | --- | --- |
| Dispatch demo site | https://dispatch-demo.dobt.co | You're lookin' at it |

More soon! :wink:

## License

[MIT](http://dobtco.mit-license.org)
