<!-- Copyright 2016 Sci-GaIA consortium

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. -->

# Hackfest services

This is the checklist to prepare the services for an e-Research Hackfest. It assumes that you will be running a full hackfest. If you are running a pared-down or specialised hackfest, then select the bits that you want in your fork. The services we refer to here are :

  * Website for the event preparation, so that attendees are fully prepared for the event.
  * development environment for for the participants to execute the warmups
  * integration platform for them to use in developing their projects
  * discussion and

There are several other

## How to use this checklist

This checklist is aimed at giving a comprehensive, default procedure for preparing for an e-Science hackfest. A full checklist is created in order to guide the team of people running the event. The goal is that organisers need simply update specific information and variables for the event, and then run the relevant playbooks and complete the tasks. Organising an event of this kind is by its nature impossible to prescribe fully - there are always going to be unforseen issues and choices which are impossible to prescribe. However, experience has shown that most of the execution of the event can be predicted, and thus prepared for. We encourage anyone running an event to provide feedback and suggestions on improving the checklists for running it.

Use this checklist when you have already read the [master checklist](../master-checklist.md) and are ready to prepare for

## Overview of the procedure




# Services

Services necessary for the hackfest are :

  1. Participant development environment - the golden standard for the development environment for the participants
  1. Integration platform - instances of the service comprising the platform that the participants will code against.

## Development environment - Automated deployment

### Participant information

  1. [ ] Collect the final participants list. Ensure that you have :
      * Name and Surname
      * email address
      * preferred user name
      * ssh public key

      Of each participant.

  1. [ ] Add these to group_vars file for the events

### Deployment

  1. [ ] Decide on the cloud provider you will be using.
     * Private Cloud (OpenStack) :
       * [ ] Check whether you have access to the Nova interface, so that you can deploy machines using DevOps tools.
       * [ ] Run the deloyment-setup playbook.
     * Commercial provider : Request _large_ VM from your provider which will be used by all participants _or_ request a _small_ VM from your provider _per participant_
  1. [ ] Ensure that the organisers ssh keys are assigned to a deployment user (_e.g._ `ansible`)


### Development Environment - manual

if you want to provision the

**Nova with Cloud-Init**

  1. [ ] Create the VM using the cloud-init file in `static-files`:
      ```
        nova boot <template name> --flavor <flavour defined in nova> --image <image id from glance> --security-groups <group from nova> --user-data <cloud init file> --poll
      ```
      _e.g._
      ```
        nova boot fg-hackfest --flavor medium --image dd66a06a-7414-49ea-becc-04a45f5bfb6c --security-groups 837af793-12f5-409c-8919-5d0545041881 --user-data futuregateway_cloud-init --poll
      ```
  1. [ ] Assign IP :
      ```
        nova floating-ip-associate <template name> <ip>
      ```
      _e.g._
      ```
        nova floating-ip-associate fg-hackfest 151.97.41.44
      ```



## Integration platform

The integration platform needs to be available in order to do continuous integration of the participant applications.


### Requirements

The integration platform consists of a Jenkins service which runs the tests

  1. [ ] Fork the Jenkins config repo
  1. [ ] Edit group_vars for your event
