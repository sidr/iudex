/*
 * Copyright (c) 2010 David Kellum
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you
 * may not use this file except in compliance with the License.  You may
 * obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied.  See the License for the specific language governing
 * permissions and limitations under the License.
 */

package iudex.simhash.gen;

import static org.junit.Assert.*;

import java.nio.CharBuffer;

import org.junit.Test;

public class TokenizerTest
{
    @Test
    public void testTokens()
    {
        assertTokens( "" );
        assertTokens( " " );
        assertTokens( "  " );

        assertTokens( "a" );
        assertTokens( " a" );
        assertTokens( "a " );

        assertTokens( "ab" );

        assertTokens( "a abc", "abc" );

        assertTokens( "abc", "abc" );
        assertTokens( " abc", "abc" );
        assertTokens( "abc ", "abc" );

        assertTokens( "abc bde", "abc", "bde" );

        assertTokens( "abc cde fgh",   "abc", "cde", "fgh" );
        assertTokens( " abc cde fgh",  "abc", "cde", "fgh" );
        assertTokens( "abc  cde fgh",  "abc", "cde", "fgh" );
        assertTokens( "abc cde fgh ",  "abc", "cde", "fgh" );
        assertTokens( "abc cde fgh  ", "abc", "cde", "fgh" );

    }

    @Test
    public void testWhitespace()
    {
        assertTokens( "abc \n\t\u200bcde fgh", "abc", "cde", "fgh" );
    }

    private void assertTokens( String input, String... tokens )
    {
        Tokenizer tokenizer = new Tokenizer( bb( input ) );

        for( String t : tokens ) {
            assertTrue( tokenizer.hasNext() );
            String next = str( tokenizer.next() );
            assertEquals( t, next );
        }
        assertFalse( tokenizer.hasNext() );
    }

    private String str( CharBuffer out )
    {
        return out.toString();
    }

    private CharBuffer bb( String input )
    {
        return CharBuffer.wrap( input );
    }

}
