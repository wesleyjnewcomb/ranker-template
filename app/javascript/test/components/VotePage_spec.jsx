import React from 'react'
import { shallow } from 'enzyme'

import VotePage from '../../src/components/VotePage'

describe('VotePage', () => {
  let wrapper
  it('renders "Vote"', () => {
    wrapper = shallow(<VotePage />)
    expect(wrapper).toIncludeText('Vote')
  })
})
