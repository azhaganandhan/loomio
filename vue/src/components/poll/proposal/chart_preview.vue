<style lang="scss">
@import 'variables';

.poll-proposal-chart-preview {
  width: 50px;
  height: 50px;
  position: relative;
}

.poll-proposal-chart-preview__stance-container {
  width: 23px;
  height: 23px;
  position: absolute;
  left: -3px;
  bottom: -5px;
  background-color: #fff;
  border-radius: 100%;
  box-shadow: 0 2px 1px rgba(0,0,0,.15);
}

.poll-proposal-chart-preview__stance {
  background-repeat: no-repeat;
  height: 21px;
  width: 21px;
  margin: 1px 0 0 1px;
}

.poll-proposal-chart-preview__stance--agree {
  background-image: url(/img/agree.svg);
}

.poll-proposal-chart-preview__stance--disagree {
  background-image: url(/img/disagree.svg);
}

.poll-proposal-chart-preview__stance--block {
  background-image: url(/img/block.svg);
}

.poll-proposal-chart-preview__stance--abstain {
  background-image: url(/img/abstain.svg);
}

.poll-proposal-chart-preview__stance--undecided {
  color: $grey-on-white;
  font-weight: bold;
  font-size: 16px;
  margin-top: 2px;
  text-align: center;
}

</style>

<script lang="coffee">
module.exports =
  props:
    stanceCounts: Array
    myStance: Object
</script>

<template>
    <div class="poll-proposal-chart-preview">
      <poll-proposal-chart
        :stance-counts="stanceCounts"
        :diameter="50"
        class="poll-common-collapsed__pie-chart"
      ></poll-proposal-chart>
      <div class="poll-proposal-chart-preview__stance-container">
        <div
          v-if="this.myStance"
          :class="`poll-proposal-chart-preview__stance poll-proposal-chart-preview__stance--${this.myStance.pollOption().name}`"
        ></div>
        <div
          v-if="!this.myStance"
          class="poll-proposal-chart-preview__stance poll-proposal-chart-preview__stance--undecided"
        >?</div>
      </div>
    </div>
</template>
