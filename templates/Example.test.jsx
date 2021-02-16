import React from 'react'
import { mount } from 'enzyme'

import Example from './Example'

describe('Example Component', () => {
    let wrapper

    beforeEach(() => {
        wrapper = mount(<Example name="Filip" />)
    })

    it('renders the correct content', () => {
        expect(wrapper.find('.example h1').text()).toBe('Hello Filip')
    })
})