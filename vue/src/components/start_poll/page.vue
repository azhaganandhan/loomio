<style lang="scss">
@import 'variables';
.start-poll-page {
  margin-top: $cardPaddingSize;
}

.start-poll-page__main-content {
  justify-content: center;
}
</style>

<script lang="coffee">
Records       = require 'shared/services/records'
EventBus      = require 'shared/services/event_bus'
ModalService  = require 'shared/services/modal_service'
LmoUrlService = require 'shared/services/lmo_url_service'

{ listenForLoading }       = require 'shared/helpers/listen'
{ iconFor }                = require 'shared/helpers/poll'
{ applyPollStartSequence } = require 'shared/helpers/apply'

module.exports =
  data: ->
    poll: Records.polls.build
      title:       @$route.params.title
      pollType:    @$route.params.poll_type
      groupId:     parseInt(@$route.params.group_id)
      customFields:
        pending_emails: _.compact((@$route.params.pending_emails || "").split(','))
  created: ->
    EventBus.$emit 'currentComponent', { page: 'startPollPage', skipScroll: true }
    Records.groups.findOrFetch(@$route.params.group_id).then =>
      # applyPollStartSequence @,
      #   emitter: @
      #   afterSaveComplete: (event) =>
      #     ModalService.open 'AnnouncementModal', announcement: =>
      #       Records.announcements.buildFromModel(event)
    # listenForLoading $scope
  computed:
    icon: ->
      iconFor(@poll)
</script>

<template>
  <div class="lmo-one-column-layout">
    <main class="start-poll-page lmo-row">
      <div layout="column" class="start-poll-page__main-content lmo-flex lmo-card lmo-relative">
        <!-- <div v-if="isDisabled" class="lmo-disabled-form"></div> -->
        <div v-if="!poll.pollType" class="poll-common-start-poll__header lmo-flex">
          <h2 v-t="'poll_common.start_poll'" class="lmo-card-heading"></h2>
        </div>
        <div v-if="poll.pollType" class="poll-common-start-poll__header lmo-flex">
          <i :class="'mdi' + icon()"></i>
          <h2 v-t="'poll_types.' + poll.pollType" class="lmo-card-heading poll-common-card-header__poll-type"></h2>
        </div>
        <div class="poll-common-start-poll">
          <!-- <poll-common-choose-type v-if="currentStep == 'choose'" :poll="poll" class="animated"></poll-common-choose-type>
          <poll-common-directive v-if="currentStep == 'save'" :poll="poll" name="form" class="animated"></poll-common-directive>
          <poll-common-form-actions v-if="currentStep == 'save'" :poll="poll"></poll-common-form-actions> -->
        </div>
      </div>
    </main>
  </div>
</template>
