# Organiser Checklist

In roughly chronological order

  1. [ ] Clone  [`hackfest-site`](https://github.com/AAROC/hackfest-site) to a new repo.
  1. [ ] Update the metadata in `hackfest_site/_config.yml`
  1. [ ] Ensure the github keys of all of the facilitators are published.
  1. [ ] Create the agenda page (default : agenda.ct.infn.it)
  1. [ ] Set up registration
  1. [ ] Prepare for registrants
    1. [ ] copy `../../participants/participants.yml` to `participants-{{ site_name }}.yml ` for the event at your sites. Ensure that there is at least one participant (use one of the facilitators)
    1. [ ] copy `../../participants/projects.yml` to `participants-{{ site_name }}.yml ` for the event at your sites. Ensure that there is at least one project - use the default values.
  1. [ ] Create tenant for cloud services
  1. [ ] Create VMs for services
  1. [ ] Configure access to cloud services with the provided Ansible playbooks
    1. [ ] dev services - glibrary, future gateway, oar
    1. [ ] CI machine
    1. [ ] participant user interface (for warmups)
  1. [ ] Run warmups - follow the instructions in the warmup repo
    1. [ ] Does the glibrary warmup work ?
    1. [ ] Does  the FutureGateway warmup work ?
    1. [ ] Does the OAR warmup work ?
  1. [ ] Check / update content of the slides



# Keeping particpipants engaged.

Apart from the initial invitation email, a set of templates and deadlines are defined to send messages to invitees to ensure that they are up to speed.

  1. [ ] Send invitation mail
  1. [ ] Send first information mail. Use template
  1. [ ] Send [First Check-In mail](templates/First-check-in.html)
    * gather email address
    * gather github accounts
    * update participants.yml in hackfest-site repo.
