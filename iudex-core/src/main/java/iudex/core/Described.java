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

import java.util.List;

/**
 * Extension interface for components to provide additional descriptive details
 * for reporting purposes.
 */
public interface Described
{
    /**
     * Return a list of objects that are descriptive and identifying,
     * either by type, or via toString(). This list should not include class or
     * class name, which can be externally obtained. When applied to a
     * {@link iudex.core.ContentFilter} should provide short details such as
     * input/output key variables but not any child filters.
     */
    List<Object> describe();
}
