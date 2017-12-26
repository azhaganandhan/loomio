AppConfig = require 'shared/services/app_config.coffee'
Records   = require 'shared/services/records.coffee'

{ submitOnEnter } = require 'angular/helpers/keyboard.coffee'
{ submitStance }  = require 'angular/helpers/form.coffee'

angular.module('loomioApp').directive 'pollCountVoteForm', ->
  scope: {stance: '='}
  templateUrl: 'generated/components/poll/count/vote_form/poll_count_vote_form.html'
  controller: ($scope) ->
    $scope.submit = submitStance $scope, $scope.stance,
      prepareFn: (optionName) ->
        _.find $scope.stance.pollOptions(), (option) -> option.name == name
        $scope.$emit 'processing'
        $scope.stance.stanceChoicesAttributes = [poll_option_id: option.id]

    $scope.yesColor = AppConfig.pollColors.count[0]
    $scope.noColor  = AppConfig.pollColors.count[1]

    submitOnEnter($scope)