<style lang="scss">
</style>

<script lang="coffee">
import PollProposalForm from 'src/components/poll/proposal/form.vue'
import PollCommonVoteForm from 'src/components/poll/common/vote_form.vue'
import PollPollForm from 'src/components/poll/poll/form.vue'
import PollCountForm from 'src/components/poll/count/form.vue'
import PollDotVoteForm from 'src/components/poll/dot_vote/form.vue'
import PollScoreForm from 'src/components/poll/score/form.vue'
import PollMeetingForm from 'src/components/poll/meeting/form.vue'
import PollRankedChoiceForm from 'src/components/poll/ranked_choice/form.vue'
import PollCommonChangeYourVote from 'src/components/poll/common/change_your_vote.vue'
import PollProposalChartPanel from 'src/components/poll/proposal/chart_panel.vue'
import PollCommonVotesPanelStance from 'src/components/poll/common/votes_panel_stance.vue'
import PollProposalStanceChoice from 'src/components/poll/proposal/stance_choice.vue'
import PollCountStanceChoice from 'src/components/poll/count/stance_choice.vue'
import PollCountChartPanel from 'src/components/poll/count/chart_panel.vue'
import PollPollVoteForm from 'src/components/poll/poll/vote_form.vue'
import PollDotVoteVoteForm from 'src/components/poll/dot_vote/vote_form.vue'
import PollDotVoteStanceChoice from 'src/components/poll/dot_vote/stance_choice.vue'
import PollPollStanceChoice from 'src/components/poll/poll/stance_choice.vue'
import PollPollChartPanel from 'src/components/poll/poll/chart_panel.vue'
import PollCommonBarChartPanel from 'src/components/poll/common/bar_chart_panel.vue'
import PollDotVoteChartPanel from 'src/components/poll/dot_vote/chart_panel.vue'
import PollScoreVoteForm from 'src/components/poll/score/vote_form.vue'
import PollScoreChartPanel from 'src/components/poll/score/chart_panel.vue'
import PollCommonStanceChoice from 'src/components/poll/common/stance_choice.vue'
import PollRankedChoiceVoteForm from 'src/components/poll/ranked_choice/vote_form.vue'
import PollMeetingVoteForm from 'src/components/poll/meeting/vote_form.vue'
import PollMeetingChartPanel from 'src/components/poll/meeting/chart_panel.vue'
import PollMeetingChangeYourVote from 'src/components/poll/meeting/change_your_vote.vue'
import PollMeetingVotesPanelStance from 'src/components/poll/meeting/votes_panel_stance.vue'
module.exports =
  components:
    'poll-proposal-form': PollProposalForm
    'poll-common-vote-form': PollCommonVoteForm
    'poll-poll-form': PollPollForm
    'poll-count-form': PollCountForm
    'poll-dot_vote-form': PollDotVoteForm
    'poll-score-form': PollScoreForm
    'poll-meeting-form': PollMeetingForm
    'poll-ranked_choice-form': PollRankedChoiceForm
    'poll-common-change-your-vote': PollCommonChangeYourVote
    'poll-proposal-chart-panel': PollProposalChartPanel
    'poll-common-votes-panel-stance': PollCommonVotesPanelStance
    'poll-proposal-stance-choice': PollProposalStanceChoice
    'poll-count-stance-choice': PollCountStanceChoice
    'poll-count-chart-panel': PollCountChartPanel
    'poll-poll-vote-form': PollPollVoteForm
    'poll-dot_vote-vote-form': PollDotVoteVoteForm
    'poll-dot_vote-stance-choice': PollDotVoteStanceChoice
    'poll-poll-stance-choice': PollPollStanceChoice
    'poll-poll-chart-panel': PollPollChartPanel
    'poll-common-bar-chart-panel': PollCommonBarChartPanel
    'poll-dot_vote-chart-panel': PollDotVoteChartPanel
    'poll-score-vote-form': PollScoreVoteForm
    'poll-score-chart-panel': PollScoreChartPanel
    'poll-common-stance-choice': PollCommonStanceChoice
    'poll-ranked_choice-vote-form': PollRankedChoiceVoteForm
    'poll-meeting-vote-form': PollMeetingVoteForm
    'poll-meeting-chart-panel': PollMeetingChartPanel
    'poll-meeting-change-your-vote': PollMeetingChangeYourVote
    'poll-meeting-votes-panel-stance': PollMeetingVotesPanelStance
  props:
    poll: Object
    stance: Object
    outcome: Object
    stanceChoice: Object
    back: Object
    name: String
  methods:
    componentName: ->
      pollType = (@stance or @outcome or @stanceChoice or @poll).poll().pollType

      console.log "poll-#{pollType}-#{@name}"

      if @$options.components["poll-#{pollType}-#{@name}"]
        console.log 'match with ', "poll-#{pollType}-#{@name}"
        "poll-#{pollType}-#{@name}"
      else
        console.log 'no match, falling through to common ', "poll-common-#{@name}"
        "poll-common-#{@name}"
</script>

<template>
  <component :is="componentName()" :poll='poll' :stance='stance' :stance-choice='stanceChoice' :outcome='outcome' :back='back'></component>
</template>
