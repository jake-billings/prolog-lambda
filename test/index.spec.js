/* Copyright (C) Jake Billings 2018
 * Use granted under MIT LICENSE found in
 * file in root directory of this repository
 */
import {expect} from 'chai';
import {handler} from '../src';

import LambdaTester from 'lambda-tester';

describe('index', () => {
    describe('handler()', () => {
        it('should exist', () => {
            expect(handler).to.exist;
            expect(handler).to.be.a('function');
        });
    });
});