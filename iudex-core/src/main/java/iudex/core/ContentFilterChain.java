/*
 * Copyright (C) 2008-2009 David Kellum
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package iudex.core;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import com.gravitext.htmap.UniMap;
import com.gravitext.util.Closeable;

public class ContentFilterChain
    implements ContentFilterContainer, Described
{
    public ContentFilterChain( String description,
                               List<ContentFilter> filters )
    {
        _description = description;
        _filters = new ArrayList<ContentFilter>( filters );
    }

    public boolean filter( UniMap content )
    {
        // TODO Auto-generated method stub
        return false;
    }

    @Override
    public List<ContentFilter> children()
    {
        return Collections.unmodifiableList( _filters );
    }

    @Override
    public void close()
    {
        for( ContentFilter f : _filters ) {
            if( f instanceof Closeable ) ( (Closeable) f ).close();
        }
    }

    @Override
    public List<Object> describe()
    {
        return Arrays.asList( (Object) _description );
    }

    private final String _description;
    private final ArrayList<ContentFilter> _filters;
}
