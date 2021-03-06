<script lang="coffee">
AppConfig      = require 'shared/services/app_config'
Session        = require 'shared/services/session'
Records        = require 'shared/services/records'
AbilityService = require 'shared/services/ability_service'
ModalService   = require 'shared/services/modal_service'

module.exports =
  props:
    group: Object
  data: ->
    isGroupExportModalOpen: false
    isLeaveGroupModalOpen: false
    isArchiveGroupModalOpen: false
  methods:
    openChangeVolumeForm: ->
      ModalService.open 'ChangeVolumeForm', model: => @group.membershipFor(Session.user())

    editGroup: ->
      ModalService.open 'GroupModal', group: => @group

    addSubgroup: ->
      ModalService.open 'GroupModal', group: => Records.groups.build(parentId: @group.id)

    openGroupExportModal: ->
      @isGroupExportModalOpen = true
    closeGroupExportModal: ->
      @isGroupExportModalOpen = false
    openLeaveGroupModal: ->
      @isLeaveGroupModalOpen = true
    closeLeaveGroupModal: ->
      @isLeaveGroupModalOpen = false
    openArchiveGroupModal: ->
      @isArchiveGroupModalOpen = true
    closeArchiveGroupModal: ->
      @isArchiveGroupModalOpen = false

  computed:
    groupExportModalConfirmOpts: ->
      submit: @group.export
      text:
        title:    'group_export_modal.title'
        helptext: 'group_export_modal.body'
        submit:   'group_export_modal.submit'
        flash:    'group_export_modal.flash'

    leaveGroupModalConfirmOpts: ->
      submit:  Session.user().membershipFor(@group).destroy
      text:
        title:    'leave_group_form.title'
        helptext: 'leave_group_form.question'
        confirm:  'leave_group_form.submit'
        flash:    'group_page.messages.leave_group_success'
      redirect: 'dashboard'

    archiveGroupModalConfirmOpts: ->
      submit:     @group.archive
      text:
        title:    'archive_group_form.title'
        helptext: 'archive_group_form.question'
        flash:    'group_page.messages.archive_group_success'
      redirect:   'dashboard'

    canExportData: ->
      Session.user().isMemberOf(@group)

    canAdministerGroup: ->
      AbilityService.canAdministerGroup(@group)

    canEditGroup: ->
      AbilityService.canEditGroup(@group)

    canAddSubgroup: ->
      AbilityService.canCreateSubgroups(@group)

    canArchiveGroup: ->
      AbilityService.canArchiveGroup(@group)

    canLeaveGroup: ->
      AbilityService.canRemoveMembership(@group.membershipFor(Session.user()))

    canChangeVolume: ->
      AbilityService.canChangeGroupVolume(@group)
</script>

<template lang="pug">
v-menu.group-page-actions.lmo-no-print(offset-y)
  v-btn.group-page-actions__button(flat slot='activator')
    span(v-t="'group_page.options.label'")
    v-icon mdi-chevron-down
  v-list.group-actions-dropdown__menu-content
    v-list-tile.group-page-actions__edit-group-link(v-if='canEditGroup', @click='editGroup()' v-t="'group_page.options.edit_group'")
      v-list-tile-title(v-t="'group_page.options.edit_group'")
    v-list-tile.group-page-actions__change-volume-link(v-if='canChangeVolume', @click='openChangeVolumeForm()')
      v-list-tile-title(v-t="'group_page.options.email_settings'")
      //- <outlet name="after-group-actions-manage-memberships" model="group"></outlet>
      //- <outlet name="after-group-actions-manage-memberships-2" model="group"></outlet>
    v-list-tile.group-page-actions__export-json(v-if='canExportData', @click='openGroupExportModal()')
      v-list-tile-title(v-t="'group_page.options.export_data'")
    v-dialog(v-model="isGroupExportModalOpen", lazy persistent)
      confirm-modal(:confirm="groupExportModalConfirmOpts", :close="closeGroupExportModal")

    v-list-tile.group-page-actions__leave-group(v-if='canLeaveGroup', @click='openLeaveGroupModal()')
      v-list-tile-title(v-t="'group_page.options.leave_group'")
    v-dialog(v-model="isLeaveGroupModalOpen", lazy persistent)
      confirm-modal(:confirm="leaveGroupModalConfirmOpts", :close="closeLeaveGroupModal")

    v-list-tile.group-page-actions__archive-group(v-if='canArchiveGroup', @click='openArchiveGroupModal()')
      v-list-tile-title(v-t="'group_page.options.deactivate_group'")
    v-dialog(v-model="isArchiveGroupModalOpen", lazy persistent)
      confirm-modal(:confirm="archiveGroupModalConfirmOpts", :close="closeArchiveGroupModal")
</template>
