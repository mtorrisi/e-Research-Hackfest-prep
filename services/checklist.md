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

This is the checklist to prepare the services for an e-Research Hackfest. It assumes that you will be running a full hackfest. If you are running a pared-down or specialised hackfest, then select the bits that you want in your fork.

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
  1. [ ] Add these to group_vars file

### Deployment

  1. [ ] Decide on the cloud provider you will be using.
     * Private Cloud (OpenStack) :
       * [ ] Check whether you have access to the Nova interface, so that you can deploy machines using DevOps tools.
       * [ ] Run the deloyment-setup playbook.
     * Commercial provider : Request _large_ VM from your provider which will be used by all participants _or_ request a _small_ VM from your provider _per participant_
  1. [ ] Ensure that the organisers ssh keys are assigned to a deployment user (_e.g._ `ansible`)


### Development Environment - manual

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
  1.

## Integration platform

The integration platform needs to be available in order to do continuous integration of the participant applications.


### Requirements

The integration platform consists of a Jenkins service which runs the tests

  1. [ ] Fork the Jenkins config repo
  1. [ ] Edit group_vars for your event
  1. [ ]
