<style lang="scss">
.start-discussion-page {
  // margin-top: $cardPaddingSize;
}
</style>
<script lang="coffee">
Records       = require 'shared/services/records'
ModalService  = require 'shared/services/modal_service'
LmoUrlService = require 'shared/services/lmo_url_service'

{ applyDiscussionStartSequence } = require 'shared/helpers/apply'
{ listenForLoading }             = require 'shared/helpers/listen'

module.exports =
  data: ->
    discussion: null
    isDisabled: false
  created: ->
    @init()
  methods:
    init: ->
      # $rootScope.$broadcast('currentComponent', { page: 'startDiscussionPage', skipScroll: true })
      @discussion = Records.discussions.build
        title:       @$route.params.title
        groupId:     parseInt(@$route.params.group_id)

      # listenForLoading $scope

      Records.groups.findOrFetch(@$route.params.group_id).then =>
        # applyDiscussionStartSequence @,
        #   emitter: @
        #   afterSaveComplete: (event) ->
        #     ModalService.open 'AnnouncementModal', announcement: ->
        #       Records.announcements.buildFromModel(event)
</script>
<template>
  <div class="lmo-one-column-layout">
    <main class="start-discussion-page lmo-row">
      <div layout="column" class="start-discussion-page__main-content lmo-flex lmo-card lmo-relative">
        <div v-if="isDisabled" class="lmo-disabled-form"></div>
        <div class="discussion-start-discussion__header lmo-flex lmo-flex__center"><i class="mdi mdi-forum lmo-margin-right"></i>
          <h2 v-t="'discussion_form.new_discussion_title'" class="lmo-card-heading"></h2></div>
        <div class="discussion-start-discussion">
          <discussion-form :discussion="discussion"></discussion-form>
          <discussion-form-actions :discussion="discussion"></discussion-form-actions>
        </div>
      </div>
    </main>
  </div>
</template>
